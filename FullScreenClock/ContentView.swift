import SwiftUI

enum Fonts {
    static let regular = Font.system(
        size: 240,
        weight: .regular,
        design: .rounded
    )
    static let small = Font.system(
        size: 140,
        weight: .medium,
        design: .rounded
    )
    static let monospaced = regular.monospacedDigit()
}

enum DebugModes: Int {
    case regular
    case millisecond
    case random
    case fixed
}
let debugMode = DebugModes.regular.rawValue

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        let isLandscape = horizontalSizeClass == .regular
        let layout = isLandscape
            ? AnyLayout(HStackLayout(alignment: .firstTextBaseline))
            : AnyLayout(VStackLayout(spacing: -40))

        TimelineView(.periodic(from: Date(), by: [0.01, 0.0025, 0.05, 0.01][debugMode])) { context in
            layout {
                HoursView(date: context.date, isLandscape: isLandscape)
                if isLandscape {
                    ColonView()
                }
                MinutesView(date: context.date, isLandscape: isLandscape)
                SecondsView(date: context.date, isLandscape: isLandscape)
            }
            .frame(width: 804, alignment: isLandscape ? .leading : .center)
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
    }
}

struct HoursView: View {
    let date: Date
    let isLandscape: Bool
    var body: some View {
        [
            Text(date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted)))),
            Text(date.formatted(.dateTime.secondFraction(.fractional(2)))),
            Text("\(Int.random(in: 0...2))\(Int.random(in: 0...9))"),
            Text("00"),
        ][debugMode]
            .font(isLandscape ? Fonts.regular : Fonts.monospaced)
            .frame(width: 292, alignment: isLandscape ? .trailing : .center)
    }
}

struct MinutesView: View {
    let date: Date
    let isLandscape: Bool
    var body: some View {
        [
            Text(date.formatted(.dateTime.minute(.twoDigits))),
            Text(date.formatted(.dateTime.secondFraction(.fractional(2)))),
            Text("\(Int.random(in: 0...6))\(Int.random(in: 0...9))"),
            Text("00"),
        ][debugMode]
            .font(isLandscape ? Fonts.regular : Fonts.monospaced)
    }
}

struct SecondsView: View {
    let date: Date
    let isLandscape: Bool
    var body: some View {
        [
            Text(date.formatted(.dateTime.second(.twoDigits))),
            Text(date.formatted(.dateTime.secondFraction(.fractional(2)))),
            Text("\(Int.random(in: 0...6))\(Int.random(in: 0...9))"),
            Text("00"),
        ][debugMode]
            .font(isLandscape ? Fonts.small : Fonts.monospaced)
            .frame(width: isLandscape ? 175 : 292, alignment: isLandscape ? .leading : .center)
    }
}

struct ColonView: View {
    var body: some View {
        Text(":")
            .font(Fonts.regular)
            .offset(y: -20)
            .padding(.horizontal, -20)
    }
}

#Preview() {
    ContentView()
}

#Preview("Portrait", traits: .portrait) {
    ContentView()
        .environment(\.horizontalSizeClass, .compact)
}

#Preview("Landscape Left", traits: .landscapeRight) {
    ContentView()
        .environment(\.horizontalSizeClass, .regular)
}

#Preview("Landscape Right", traits: .landscapeLeft) {
    ContentView()
        .environment(\.horizontalSizeClass, .regular)
}
