import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        let isHorizontal = horizontalSizeClass == .regular
        let layout = isHorizontal ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
        let digitSize = isHorizontal ? 190.0 : 230.0

        TimelineView(.periodic(from: Date(), by: 0.01)) { context in
            layout {
                Text(context.date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))))
                if isHorizontal {
                    Text(":").font(.system(size: 120))
                }
                Text(context.date.formatted(.dateTime.minute(.twoDigits)))
                if isHorizontal {
                    Text(":").font(.system(size: 120))
                }
                Text(context.date.formatted(.dateTime.second(.twoDigits)))
            }
            .font(.system(size: digitSize, weight: .bold, design: .monospaced))
        }
    }
}

#Preview {
    ContentView()
}
