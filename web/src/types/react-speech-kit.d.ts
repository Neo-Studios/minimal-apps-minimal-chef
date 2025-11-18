declare module 'react-speech-kit' {
  export function useSpeechRecognition(options?: {
    onResult?: (result: string) => void;
    onStart?: () => void;
    onEnd?: () => void;
    onError?: (event: SpeechRecognitionErrorEvent) => void;
    continuous?: boolean;
    interimResults?: boolean;
    lang?: string;
  }): {
    listen: () => void;
    stop: () => void;
    listening: boolean;
    supported: boolean;
  };

  export function useSpeechSynthesis(options?: {
    onBoundary?: (event: SpeechSynthesisEvent) => void;
    onEnd?: (event: SpeechSynthesisEvent) => void;
    onError?: (event: SpeechSynthesisErrorEvent) => void;
    onMark?: (event: SpeechSynthesisEvent) => void;
    onPause?: (event: SpeechSynthesisEvent) => void;
    onResume?: (event: SpeechSynthesisEvent) => void;
    onStart?: (event: SpeechSynthesisEvent) => void;
  }): {
    speak: (options: { text: string; voice?: SpeechSynthesisVoice; rate?: number; pitch?: number; volume?: number; lang?: string; }) => void;
    cancel: () => void;
    speaking: boolean;
    supported: boolean;
    voices: SpeechSynthesisVoice[];
  };
}
