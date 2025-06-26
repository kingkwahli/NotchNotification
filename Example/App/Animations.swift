//
//  Animations.swift
//  Designed for NotchNotification
// Created by kingkwahli
import SwiftUI

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
   
struct DownloadingArrow: View {
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
