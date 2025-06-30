// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import SwiftUI

@usableFromInline
let defaultInterval: TimeInterval = 2

struct LoadingSpinner: View {
    @State private var isAnimating = false

    var body: some View {
        Image(systemName: "arrow.trianglehead.2.clockwise.rotate.90.circle")
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .animation(
                .linear(duration: 1.0).repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}

struct DownloadArrow: View {
    @State private var fade = false

    var body: some View {
        Image(systemName: "arrow.down.circle")
            .opacity(fade ? 1.0 : 0.3)
            .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: fade)
            .onAppear {
                fade = true
            }
    }
}

public enum NotchNotification {
    public static func present(message: String, interval: TimeInterval = defaultInterval) {
        present(
            bodyView: Text(message),
            interval: interval
        )
    }
    public static func present(error: Error, interval: TimeInterval = defaultInterval) {
        present(error: error.localizedDescription, interval: interval)
    }
    public static func present(loading: String, interval: TimeInterval = defaultInterval) {
            present(
                trailingView: LoadingSpinner(),
                bodyView: Text(loading),
                interval: interval
            )
        }
    public static func present(download: String, interval: TimeInterval = defaultInterval) {
            present(
                trailingView: DownloadArrow(),
                bodyView: Text(download),
                interval: interval
            )
        }
    public static func present(error: String, interval: TimeInterval = defaultInterval) {
        present(
            trailingView: Image(systemName: "xmark").foregroundStyle(.red),
            bodyView: Text(error),
            interval: interval
        )
    }

    public static func present(success: String, interval: TimeInterval = defaultInterval) {
        present(
            trailingView: Image(systemName: "checkmark").foregroundStyle(.green),
            bodyView: Text(success),
            interval: interval
        )
    }
    public static func present(camera: String, interval: TimeInterval = defaultInterval) {
        present(
            leadingView: Rectangle().hidden().frame(width: 4),
            trailingView: Rectangle().hidden().frame(width: 4).overlay(Circle().frame(width: 4, height: 4).foregroundStyle(.green)),
            bodyView: EmptyView().frame(width: 0, height: 0),
            interval: interval,
            animated: false
        )
    }
    public static func present(microphone: String, interval: TimeInterval = defaultInterval) {
        present(
            leadingView: Rectangle().hidden().frame(width: 4),
            trailingView: Rectangle().hidden().frame(width: 4).overlay(Circle().frame(width: 4, height: 4).foregroundStyle(.orange)),
            bodyView: EmptyView().frame(width: 0, height: 0),
            interval: interval,
            animated: false
        )
    }
    public static func present(custom: String, interval: TimeInterval = defaultInterval, sfsymbol: String) {
            present(
                trailingView: Image(systemName: sfsymbol).foregroundStyle(.white),
                bodyView: Text(custom),
                interval: interval
            )
        }
    public static func present(icon: String, interval: TimeInterval = defaultInterval, sfsymbol: String) {
            present(
                leadingView: Rectangle().hidden().frame(width: 4),
                trailingView: Image(systemName: sfsymbol).foregroundStyle(.white),
                bodyView: EmptyView().frame(width: 0, height: 0),
                interval: interval,
                animated: false
            )
        }
    public static func present(
        leadingView: some View = Image(systemName: "bell.fill"),
        trailingView: some View = EmptyView(),
        bodyView: some View = EmptyView().frame(width: 0, height: 0),
        interval: TimeInterval = 3,
        animated: Bool = true
    ) {
    
        let leadingView = leadingView
            .foregroundStyle(.white)
            .font(.system(.body, design: .rounded).weight(.bold))
        let trailingView = trailingView
            .foregroundStyle(.white)
            .font(.system(.title2, design: .rounded).weight(.bold))
        let bodyView = bodyView
            .foregroundStyle(.white)
            .font(.system(.body, design: .rounded))

        guard let context = NotificationContext(
            headerLeadingView: leadingView,
            headerTrailingView: trailingView,
            bodyView: bodyView,
            animated: animated
        ) else {
            return
        }

        context.open(forInterval: interval)
    }
}
