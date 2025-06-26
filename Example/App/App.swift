//
//  App.swift
//  NotchNotification
//
//  Created by 秋星桥 on 2024/9/19.
//

import NotchNotification
import SwiftUI

@main
struct App: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            panel
                .frame(
                    minWidth: 500, idealWidth: 500, maxWidth: 800,
                    minHeight: 200, idealHeight: 200, maxHeight: 800,
                    alignment: .center
                )
                .background(.ultraThinMaterial)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
    @State private var showPopover = false
    @State var message: String = "Notification message here"
    @State var interval: TimeInterval = 3 {
        didSet { if interval < 0 { interval = 0 } }
    }

    var panel: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Notch Notification")
                    .bold()
                Spacer()
                Button(action: {
                                showPopover.toggle()
                            }) {
                                Image(systemName: "questionmark.circle")
                            }
                            .buttonStyle(.plain) // Prevent default button style
                            .popover(isPresented: $showPopover, arrowEdge: .bottom) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("About Notch Notification")
                                        .font(.headline)
                                    Text("Integrate your app's notifications into the MacBook notch")
                                        .font(.subheadline)
                                    Link("Learn more", destination: URL(string: "https://github.com/Lakr233/NotchNotification")!)                                }
                                .padding()
                                .frame(width: 250)
                            }
                        }
            TextField("Message", text: $message)
                .frame(minWidth: 300)
            HStack {
                Group {
                    if interval <= 0 {
                        Text("inf")
                    } else {
                        Text("\(Int(interval))s")
                    }
                }
                .frame(width: 24, alignment: .leading)
                Button("-") { interval -= 1 }
                    .disabled(interval <= 0)
                Button("+") { interval += 1 }
                    .disabled(interval >= 16)
                Spacer()
                Button("Error") {
                    NotchNotification.present(error: message)
                }
                Button("Success") {
                    NotchNotification.present(
                        trailingView: Image(systemName: "checkmark").foregroundStyle(.green),
                        bodyView: Text(message),
                        interval: interval
                    )
                }
                Button("Loading") {
                    NotchNotification.present(
                        trailingView: LoadingSpinner()
                            .font(.title2),
                        bodyView: Text(message),
                        interval: interval
                    )
                }
                Button("Downloading/Importing") {
                    NotchNotification.present(
                        trailingView: DownloadingArrow()
                            .font(.title2),
                        bodyView: Text(message),
                        interval: interval
                    )
                }
                Button("Message") {
                    NotchNotification.present(
                        trailingView: Image(systemName: "apple.logo").foregroundStyle(.black),
                        bodyView: HStack {
                            Text(message)
                        },
                        interval: interval
                    )
                }
                Button("Spying!") {
                    NotchNotification.present(
                        leadingView: Rectangle().hidden().frame(width: 4),
                        trailingView: Rectangle().hidden().frame(width: 4).overlay(Circle().frame(width: 4, height: 4).foregroundStyle(.green)),
                        bodyView: EmptyView().frame(width: 0, height: 0),
                        interval: interval,
                        animated: false
                    )
                }
            }
        }
        .padding(32)
    }
}
