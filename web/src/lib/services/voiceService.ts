class VoiceService {
  private recognition: any = null
  private synthesis: SpeechSynthesis | null = null

  constructor() {
    if (typeof window !== 'undefined') {
      const SpeechRecognition = (window as any).SpeechRecognition || (window as any).webkitSpeechRecognition
      if (SpeechRecognition) {
        this.recognition = new SpeechRecognition()
        this.recognition.continuous = false
        this.recognition.interimResults = false
      }
      this.synthesis = window.speechSynthesis
    }
  }

  startListening(onResult: (text: string) => void, onError?: (error: any) => void) {
    if (!this.recognition) return

    this.recognition.onresult = (event: any) => {
      const text = event.results[0][0].transcript
      onResult(text)
    }

    if (onError) {
      this.recognition.onerror = onError
    }

    this.recognition.start()
  }

  stopListening() {
    if (this.recognition) {
      this.recognition.stop()
    }
  }

  speak(text: string, rate: number = 1.0) {
    if (!this.synthesis) return

    const utterance = new SpeechSynthesisUtterance(text)
    utterance.rate = rate
    this.synthesis.speak(utterance)
  }

  stopSpeaking() {
    if (this.synthesis) {
      this.synthesis.cancel()
    }
  }

  isSupported(): boolean {
    return this.recognition !== null && this.synthesis !== null
  }
}

export const voiceService = new VoiceService()
