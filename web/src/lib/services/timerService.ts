import { CookingTimer } from '@/types/models'

class TimerService {
  private timers: Map<string, NodeJS.Timeout> = new Map()
  private callbacks: Map<string, (timer: CookingTimer) => void> = new Map()

  startTimer(timer: CookingTimer, onTick: (timer: CookingTimer) => void, onComplete: () => void) {
    this.stopTimer(timer.id)
    
    this.callbacks.set(timer.id, onTick)
    
    const interval = setInterval(() => {
      timer.remainingTime -= 1
      
      if (timer.remainingTime <= 0) {
        this.stopTimer(timer.id)
        onComplete()
      } else {
        onTick(timer)
      }
    }, 1000)
    
    this.timers.set(timer.id, interval)
  }

  stopTimer(timerId: string) {
    const interval = this.timers.get(timerId)
    if (interval) {
      clearInterval(interval)
      this.timers.delete(timerId)
      this.callbacks.delete(timerId)
    }
  }

  pauseTimer(timerId: string) {
    this.stopTimer(timerId)
  }

  stopAllTimers() {
    this.timers.forEach((_, id) => this.stopTimer(id))
  }
}

export const timerService = new TimerService()
