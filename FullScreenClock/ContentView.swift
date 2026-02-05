import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        let isLandscape = horizontalSizeClass == .regular
        let layout = isLandscape
            ? AnyLayout(HStackLayout(alignment: .firstTextBaseline))
            : AnyLayout(VStackLayout(spacing: -40))
        let defaultSize = 240.0
        let defaultWeight = Font.Weight.regular
        let defaultDesign = Font.Design.rounded

        TimelineView(.periodic(from: Date(), by: 0.01)) { context in
            layout {
                Text(context.date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))))
                if isLandscape {
                    Text(":")
                        .offset(y: -20)
                        .padding(.horizontal, -20)
                }
                Text(context.date.formatted(.dateTime.minute(.twoDigits)))
                Text(context.date.formatted(.dateTime.second(.twoDigits)))
                    .font(.system(size: isLandscape ? 140 : defaultSize, weight: defaultWeight, design: defaultDesign))
            }
            .font(.system(size: defaultSize, weight: defaultWeight, design: defaultDesign))
            .monospacedDigit()
        }
    }
}

#Preview {
    ContentView()
}
