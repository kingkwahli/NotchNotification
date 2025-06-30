# NotchNotification 
## Display notifications through the MacBook notch area.

NotchNotification is a refined and extended version of [NotchDrop](https://github.com/Lakr233/NotchDrop).

The original project is by [Lakr233](https://github.com/Lakr233/). 

This fork includes additional notification types like loading/syncing, importing/downloading, easier SF Symbols customization, microphone activity mode, and fixes for layout issues such as clipped icons in Message mode.

## Demo

See it in action with the [demo app](https://github.com/kingkwahli/NotchNotification-Demo/) or with the DemoApp.swift included in the project

## Platforms

NotchNotification supports all AppKit-based macOS applications (macOS 12 or later), and gracefully falls back on devices without a physical notch.

## Installation & Usage

### Basic Usage

To add this package to your project:

```swift
dependencies: [
    .package(url: "https://github.com/kingkwahli/NotchNotification.git", from: "2.0"),
]
```

To display a notification, use the following code:

```swift
NotchNotification.present(message: message)
```

To display a loading/syncing notification, use the following code:

```swift
NotchNotification.present(loading: message)
```

To display a downloading/importing notification, use the following code:

```swift
NotchNotification.present(import: message)
```

To display a notification to indicate the camera is active:

```swift
NotchNotification.present(camera: message)
```

To display a notification to indicate the microphone is active:

```swift
NotchNotification.present(microphone: message)
```

For presenting an error notification with a custom interval:

```swift
NotchNotification.present(error: error, interval: 3)
```

### Custom Icons

To display a notification with a custom symbol:

```swift
NotchNotification.present(notification: message, sfsymbol: apple.logo)
```

To display a notification with only a custom icon:

```swift
NotchNotification.present(icon: message, sfsymbol: apple.logo)
```

To display a notification with a custom icon and a custom interval:

```swift
NotchNotification.present(icon: message, sfsymbol: apple.logo, interval: 3)
```

### Advanced Customization

To fully customize the notification view:

```swift
NotchNotification.present(
    bodyView: HStack {
        Image(systemName: "hand.point.right")
        Text(message).bold()
        Image(systemName: "hand.point.left")
    },
    interval: interval
)
```

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for full details.

---

© 2024 Lakr Aream  
© 2025 Kwahli at NaazimCo
