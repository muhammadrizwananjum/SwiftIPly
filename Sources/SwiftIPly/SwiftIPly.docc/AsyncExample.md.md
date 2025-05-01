# Async/Await Usage

```swift
import SwiftIPly

// Basic usage
Task {
    do {
        let ip = try await IPly.getPublicIP()
        print("My public IP is: \(ip)")
    } catch {
        print("Failed to get IP: \(error.localizedDescription)")
    }
}

// Using in an async function
func logIPAddress() async {
    do {
        let ip = try await IPly.getPublicIP()
        await MainActor.run {
            self.ipLabel.text = ip
        }
    } catch {
        print("Error: \(error)")
    }
}

// With timeout
func getIPWithTimeout() async throws -> String {
    try await withThrowingTaskGroup(of: String.self) { group in
        group.addTask { try await IPly.getPublicIP() }
        group.addTask {
            try await Task.sleep(nanoseconds: 5_000_000_000)
            throw TimeoutError()
        }
        
        let result = try await group.next()!
        group.cancelAll()
        return result
    }
}
