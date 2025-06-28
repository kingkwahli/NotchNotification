//
//  App.swift
//  NotchNotification
//
//  Created by 秋星桥 on 2024/9/19.
//  Enhanced by kingkwahli on 2025/6/26.
//
import NotchNotification
import SwiftUI

@main
struct NotchNotificationDemoApp: SwiftUI.App {
    var body: some Scene {
        WindowGroup {
            panel
                .frame(
                    minWidth: 800, idealWidth: 800, maxWidth: 900,
                    minHeight: 340, idealHeight: 340, maxHeight: 440,
                    alignment: .center
                )
                .background(.ultraThinMaterial)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
    @State private var showPopover = false
    @State var message: String = ""
    @State var sfsymbol: String = ""
    @State var textStatus = true
    @State var interval: TimeInterval = 3 {
        didSet { if interval < 0 { interval = 0 } }
    }

    var panel: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Notch Notification Demo Application")
                    .font(.title)
                    .bold()
                Button(action: {
                                showPopover.toggle()
                            }) {
                                Image(systemName: "questionmark.circle")
                            }
                            .buttonStyle(.plain)
                            .popover(isPresented: $showPopover, arrowEdge: .bottom) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("About Notch Notification")
                                        .font(.headline)
                                    Text("Integrate your app's notifications into the MacBook notch")
                                        .font(.subheadline)
                                    Link("Learn more", destination: URL(string: "https://github.com/kingkwahli/NotchNotification")!)                                }
                                .padding()
                                .frame(width: 250)
                            }
                        }
            Text("Designed by Lakr233 • Enhanced by kingkwahli")
                .font(.caption)
                .bold()
            TextField("Notification Text (e.g. Hello World!)", text: $message)
                .frame(minWidth: 300)
            TextField("SF Symbol Name (e.g. circle.fill)", text: $sfsymbol)
                .frame(minWidth: 300)
            Toggle("Enable Text Area (under notch) | works only on Message", isOn: $textStatus)
                .toggleStyle(.checkbox)
            HStack {
                Group {
                    if interval <= 0 {
                        Text("Int.")
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
                Button("Custom") {
                    NotchNotification.present(
                        trailingView: Image(systemName: sfsymbol).foregroundStyle(.white),
                        bodyView: Text(message),
                        interval: interval
                    )
                }
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
                    NotchNotification.present(loading: message)
                }
                Button("Downloading") {
                    NotchNotification.present(download: message)
                }
                Button("Message") {
                    NotchNotification.present(
                        trailingView: Image(systemName: "apple.logo").foregroundStyle(.black),
                        bodyView: textStatus
                        ? AnyView(HStack {
                            Text(message)
                        })
                        : AnyView(EmptyView().frame(width: 0, height: 0)),                        interval: interval
                    )
                }
                Button("Camera") {
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

