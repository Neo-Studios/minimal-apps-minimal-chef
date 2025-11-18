"use client"

import { useCallback, useEffect, useRef, useState } from 'react'

type SpeakOptions = {
  text: string
  rate?: number
  pitch?: number
  voice?: SpeechSynthesisVoice | null
}

export function useSpeechSynthesis() {
  const [speaking, setSpeaking] = useState(false)
  const supported = typeof window !== 'undefined' && 'speechSynthesis' in window

  const speak = useCallback((options: SpeakOptions) => {
    if (!supported) return
    const { text, rate, pitch, voice } = options
    const utterance = new SpeechSynthesisUtterance(text)
    if (typeof rate === 'number') utterance.rate = rate
    if (typeof pitch === 'number') utterance.pitch = pitch
    if (voice) utterance.voice = voice

    utterance.onstart = () => setSpeaking(true)
    utterance.onend = () => setSpeaking(false)
    utterance.onerror = () => setSpeaking(false)

    // cancel any existing speech then speak
    window.speechSynthesis.cancel()
    window.speechSynthesis.speak(utterance)
  }, [supported])

  useEffect(() => {
    return () => {
      if (supported) window.speechSynthesis.cancel()
    }
  }, [supported])

  return { speak, speaking, supported }
}

type SpeechRecognitionResultCallback = (result: string) => void

export function useSpeechRecognition(opts?: { onResult?: SpeechRecognitionResultCallback }) {
  const [listening, setListening] = useState(false)
  const supported = typeof window !== 'undefined' && (window as any).SpeechRecognition || (window as any).webkitSpeechRecognition
  const recognitionRef = useRef<any | null>(null)

  useEffect(() => {
    if (!supported) return
    const Recog = (window as any).SpeechRecognition || (window as any).webkitSpeechRecognition
    const recognition = new Recog()
    recognition.lang = 'en-US'
    recognition.interimResults = false
    recognition.maxAlternatives = 1

    recognition.onresult = (event: any) => {
      const transcript = Array.from(event.results)
        .map((r: any) => r[0].transcript)
        .join('')
      opts?.onResult?.(transcript)
    }

    recognition.onstart = () => setListening(true)
    recognition.onend = () => setListening(false)
    recognition.onerror = () => setListening(false)

    recognitionRef.current = recognition

    return () => {
      try {
        recognition.stop()
      } catch (e) {
        // ignore
      }
      recognitionRef.current = null
    }
  }, [supported, opts])

  const listen = useCallback(() => {
    if (!supported || !recognitionRef.current) return
    try {
      recognitionRef.current.start()
    } catch (e) {
      // some browsers may throw if start called repeatedly
    }
  }, [supported])

  const stop = useCallback(() => {
    if (!supported || !recognitionRef.current) return
    try {
      recognitionRef.current.stop()
    } catch (e) {
      // ignore
    }
  }, [supported])

  return { listen, listening, stop, supported: Boolean(supported) }
}
