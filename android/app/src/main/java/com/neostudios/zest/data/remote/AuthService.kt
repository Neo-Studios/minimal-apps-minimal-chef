package com.neostudios.zest.data.remote

import com.google.android.gms.auth.api.signin.GoogleSignInAccount
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.auth.GoogleAuthProvider
import kotlinx.coroutines.tasks.await
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class AuthService @Inject constructor(
    private val auth: FirebaseAuth
) {
    val currentUser: FirebaseUser? get() = auth.currentUser
    
    suspend fun signInWithGoogle(account: GoogleSignInAccount): FirebaseUser? {
        val credential = GoogleAuthProvider.getCredential(account.idToken, null)
        val result = auth.signInWithCredential(credential).await()
        return result.user
    }
    
    fun signOut() {
        auth.signOut()
    }
}
