import SwiftUI
import Speech
import AVFoundation

struct CookingModeView: View {
    let recipe: Recipe
    @State private var currentStep = 0
    @State private var isListening = false
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let speechSynthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack {
            Text("Step \(currentStep + 1)")
                .font(.largeTitle)
                .padding()
            
            Text(recipe.instructions[currentStep])
                .font(.title)
                .padding()

            Spacer()

            HStack {
                Button(action: {
                    if currentStep > 0 {
                        currentStep -= 1
                        speakInstruction()
                    }
                }) {
                    Image(systemName: "arrow.left.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .disabled(currentStep == 0)

                Button(action: {
                    if isListening {
                        stopListening()
                    } else {
                        startListening()
                    }
                }) {
                    Image(systemName: isListening ? "mic.slash.circle.fill" : "mic.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                }

                Button(action: {
                    if currentStep < recipe.instructions.count - 1 {
                        currentStep += 1
                        speakInstruction()
                    }
                }) {
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                .disabled(currentStep == recipe.instructions.count - 1)
            }
            .padding()
        }
        .onAppear(perform: setupSpeech)
    }

    private func setupSpeech() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            // Handle authorization
        }
        speakInstruction()
    }

    private func speakInstruction() {
        let utterance = AVSpeechUtterance(string: "Step \(currentStep + 1): \(recipe.instructions[currentStep])")
        speechSynthesizer.speak(utterance)
    }

    private func startListening() {
        // Implementation for starting the speech recognition
        isListening = true
    }

    private func stopListening() {
        // Implementation for stopping the speech recognition
        isListening = false
    }
}
