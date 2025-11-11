import SwiftUI

struct CookingTimerView: View {
    @State private var timers: [TimerItem] = []
    @State private var newTimerName = ""
    @State private var newTimerMinutes = 10
    
    var body: some View {
        VStack {
            HStack {
                TextField("Timer name", text: $newTimerName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Stepper("\(newTimerMinutes) min", value: $newTimerMinutes, in: 1...120)
                    .frame(width: 120)
                
                Button(action: addTimer) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
            }
            .padding()
            
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(timers) { timer in
                        TimerCard(timer: timer) {
                            timers.removeAll { $0.id == timer.id }
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Cooking Timers")
    }
    
    func addTimer() {
        let timer = TimerItem(
            name: newTimerName.isEmpty ? "Timer" : newTimerName,
            duration: newTimerMinutes * 60
        )
        timers.append(timer)
        newTimerName = ""
        newTimerMinutes = 10
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

struct TimerItem: Identifiable {
    let id = UUID()
    let name: String
    let duration: Int
}

struct TimerCard: View {
    let timer: TimerItem
    let onComplete: () -> Void
    
    @State private var remainingTime: Int
    @State private var isRunning = false
    
    init(timer: TimerItem, onComplete: @escaping () -> Void) {
        self.timer = timer
        self.onComplete = onComplete
        _remainingTime = State(initialValue: timer.duration)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(timer.name)
                    .font(.headline)
                Text(formatTime(remainingTime))
                    .font(.system(size: 32, weight: .bold))
            }
            
            Spacer()
            
            Button(action: toggleTimer) {
                Image(systemName: isRunning ? "stop.circle.fill" : "play.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(isRunning ? .red : .green)
            }
        }
        .padding()
        .liquidGlass()
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if isRunning && remainingTime > 0 {
                remainingTime -= 1
                if remainingTime == 0 {
                    isRunning = false
                    NotificationService.shared.sendTimerComplete(timerName: timer.name)
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                    onComplete()
                }
            }
        }
    }
    
    func toggleTimer() {
        isRunning.toggle()
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func formatTime(_ seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return String(format: "%d:%02d", mins, secs)
    }
}
