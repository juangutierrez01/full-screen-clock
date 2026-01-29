import SwiftUI

struct ContentView: View {
    var body: some View {
        TimelineView(.periodic(from: Date(), by: 0.01)) { context in
            VStack {
                Text(context.date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))))
                Text(context.date.formatted(.dateTime.minute(.twoDigits)))
                Text(context.date.formatted(.dateTime.second(.twoDigits)))
            }
            .font(.system(size: 200, design: .monospaced))
        }
    }
}

#Preview {
    ContentView()
}
