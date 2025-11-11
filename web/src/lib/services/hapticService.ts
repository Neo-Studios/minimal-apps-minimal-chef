class HapticService {
  vibrate(pattern: number | number[]): void {
    if ('vibrate' in navigator) {
      navigator.vibrate(pattern)
    }
  }

  light(): void {
    this.vibrate(10)
  }

  medium(): void {
    this.vibrate(20)
  }

  heavy(): void {
    this.vibrate(30)
  }

  success(): void {
    this.vibrate([10, 50, 10])
  }

  error(): void {
    this.vibrate([20, 100, 20, 100, 20])
  }

  selection(): void {
    this.vibrate(5)
  }

  isSupported(): boolean {
    return 'vibrate' in navigator
  }
}

export const hapticService = new HapticService()
