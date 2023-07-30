
import SwiftUI

@MainActor class DelayedUpdater: ObservableObject {
    // @Published var value = 0　これは自動で値の変更を認識
    var value = 0 {
        willSet {
            objectWillChange.send()
        }
    } //@PublishedとobjectWillChange.sendはほぼ同じ動き。ただし、こちらは値の変更時に通知方式

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
    @StateObject var updater = DelayedUpdater()

    var body: some View {
        Text("Value is: \(updater.value)")
    }
}

#Preview {
    ContentView()
}
