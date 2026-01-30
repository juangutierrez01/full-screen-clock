import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        let isLandscape = horizontalSizeClass == .regular
        let layout = isLandscape
            ? AnyLayout(HStackLayout(alignment: .firstTextBaseline))
            : AnyLayout(VStackLayout(spacing: -40))
        let defaultSize = 250.0
        let defaultWeight = Font.Weight.regular
        let defaultDesign = Font.Design.rounded

        TimelineView(.periodic(from: Date(), by: 0.01)) { context in
            layout {
                Text(context.date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted))))
                if isLandscape {
                    Text(":")
                        .font(.system(size: 120))
                        .offset(y: -40)
                        .padding(.horizontal, -10)
                }
                Text(context.date.formatted(.dateTime.minute(.twoDigits)))
                Text(context.date.formatted(.dateTime.second(.twoDigits)))
                    .font(.system(size: isLandscape ? 140 : defaultSize, weight: defaultWeight, design: defaultDesign))
                    .monospacedDigit()
            }
            .font(.system(size: defaultSize, weight: defaultWeight, design: defaultDesign))
        }
    }
}

#Preview {
    ContentView()
}
