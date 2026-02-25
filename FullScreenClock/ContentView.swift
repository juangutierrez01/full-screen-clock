import SwiftUI

enum Fonts {
    static let big = Font.system(
        size: 242,
        weight: .medium,
        design: .rounded
    )
    static let small = Font.system(
        size: 140,
        weight: .semibold,
        design: .rounded
    )
    static let monospaced = big.monospacedDigit()
    static let colon = big.weight(.regular)
}

enum Kernings {
    static let big = -6.0
    static let small = -3.0
}

enum DebugModes: Int {
    case regular
    case millisecond
    case random
    case thinnest
    case widest
}
let debugMode = DebugModes.regular.rawValue

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        let isLandscape = horizontalSizeClass == .regular
        let layout = isLandscape
            ? AnyLayout(HStackLayout(alignment: .firstTextBaseline))
            : AnyLayout(VStackLayout(spacing: -50))

        TimelineView(.periodic(from: Date(), by: [0.01, 0.0025, 0.05, 0.01, 0.01][debugMode])) { context in
            layout {
                HoursView(date: context.date, isLandscape: isLandscape)
                if isLandscape {
                    ColonView()
                }
                MinutesView(date: context.date, isLandscape: isLandscape)
                SecondsView(date: context.date, isLandscape: isLandscape)
            }
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
            Text("11"),
            Text("00"),
        ][debugMode]
            .font(isLandscape ? Fonts.big : Fonts.monospaced)
            .kerning(Kernings.big)
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
            Text("11"),
            Text("00"),
        ][debugMode]
            .font(isLandscape ? Fonts.big : Fonts.monospaced)
            .kerning(Kernings.big)
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
            Text("11"),
            Text("00"),
        ][debugMode]
            .font(isLandscape ? Fonts.small : Fonts.monospaced)
            .kerning(isLandscape ? Kernings.small : Kernings.big)
            .frame(width: isLandscape ? 173 : 294, alignment: isLandscape ? .leading : .center)
    }
}

struct ColonView: View {
    var body: some View {
        Text(":")
            .font(Fonts.colon)
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
