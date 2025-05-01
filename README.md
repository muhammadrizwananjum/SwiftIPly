# SwiftIPly

**SwiftIPly** is a lightweight, concurrency-safe Swift library that helps you fetch your device's **public IP address** using the free API [`https://api.myip.com`](https://api.myip.com).  
It supports both modern `async/await` and legacy completion handler styles for broad compatibility.

---

## 📦 Installation

### Using Swift Package Manager (SPM)

You can add **SwiftIPly** to your project in Xcode by navigating to:

```
File → Add Packages → Enter URL:
https://github.com/muhammadrizwananjum/SwiftIPly.git
```

Or add it manually in your `Package.swift`:

```swift
.package(url: "https://github.com/muhammadrizwananjum/SwiftIPly.git", from: "1.0.0")
```

Add `SwiftIPly` to your target's dependencies:

```swift
.target(name: "YourAppTarget", dependencies: ["SwiftIPly"])
```

---

## 🚀 Usage

### Modern Async/Await API

```swift
import SwiftIPly

Task {
    do {
        let ip = try await SwiftIPly.getPublicIP()
        print("Public IP: \(ip)")
    } catch {
        print("Failed to fetch IP: \(error)")
    }
}
```

### Completion Handler API

```swift
import SwiftIPly

SwiftIPly.getPublicIP { result in
    switch result {
    case .success(let ip):
        print("Public IP: \(ip)")
    case .failure(let error):
        print("Error fetching IP: \(error)")
    }
}
```

---

## 📚 Documentation

SwiftIPly includes [DocC](https://developer.apple.com/documentation) documentation support.

In Xcode:
- Select **Product → Build Documentation**
- Optionally preview it by choosing **Window → Developer Documentation**

---

## ✅ Requirements

- iOS 13.0+
- macOS 10.15+
- watchOS 6.0+
- tvOS 13.0+
- Swift 5.7+

---

## 📝 License

This project is licensed under the MIT License.  
See [LICENSE](./LICENSE) for more details.
