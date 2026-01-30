import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .regular {
            TimelineView(.periodic(from: Date(), by: 0.01)) { context in
                HStack {
                    Text(context.date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))))
                    Text(":").font(.system(size: 120))
                    Text(context.date.formatted(.dateTime.minute(.twoDigits)))
                    Text(":").font(.system(size: 120))
                    Text(context.date.formatted(.dateTime.second(.twoDigits)))
                }
                .font(.system(size: 190, weight: .bold, design: .monospaced))
            }
        }
        else {
            TimelineView(.periodic(from: Date(), by: 0.01)) { context in
                VStack {
                    Text(context.date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))))
                    Text(context.date.formatted(.dateTime.minute(.twoDigits)))
                    Text(context.date.formatted(.dateTime.second(.twoDigits)))
                }
                .font(.system(size: 230, weight: .bold, design: .monospaced))
            }
        }
    }
}

#Preview {
    ContentView()
}
