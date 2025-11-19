import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import Combine // Import Combine for @Published

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isAuthenticated = false
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showOnboarding: Bool = false // New onboarding state
    
    private let firebaseService = FirebaseService.shared
    private let userProfileManager = UserProfileManager() // Instantiate UserProfileManager
    
    init() {
        // Check if user is already signed in
        self.user = Auth.auth().currentUser
        self.isAuthenticated = user != nil
        
        // Listen for auth state changes
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.user = user
                self?.isAuthenticated = user != nil
                
                if let userId = user?.uid {
                    self?.userProfileManager.getOnboardingStatus(userId: userId) { hasCompletedOnboarding in
                        self?.showOnboarding = !hasCompletedOnboarding
                    }
                } else {
                    self?.showOnboarding = false
                }
            }
        }
    }
    
    func signInWithGoogle() async -> Bool {
        isLoading = true
        errorMessage = nil
        
        do {
            // Get the client ID from Firebase config
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                errorMessage = "Failed to get client ID"
                isLoading = false
                return false
            }
            
            // Configure Google Sign In
            let config = GIDConfiguration(clientID: clientID)
            GIDSignIn.sharedInstance.configuration = config
            
            // Get the root view controller
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                errorMessage = "Failed to get root view controller"
                isLoading = false
                return false
            }
            
            // Start the sign in flow
            let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            
            guard let idToken = result.user.idToken?.tokenString else {
                errorMessage = "Failed to get ID token"
                isLoading = false
                return false
            }
            
            let accessToken = result.user.accessToken.tokenString
            
            // Create Firebase credential
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            // Sign in to Firebase
            let authResult = try await Auth.auth().signIn(with: credential)
            
            // Create user profile if needed
            try await firebaseService.createUserProfile(
                userId: authResult.user.uid,
                email: authResult.user.email ?? "",
                displayName: authResult.user.displayName ?? "User"
            )
            
            isLoading = false
            return true
            
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    // New function to complete onboarding
    func completeOnboarding(userId: String) {
        userProfileManager.setOnboardingStatus(userId: userId, status: true)
        showOnboarding = false
    }
}
