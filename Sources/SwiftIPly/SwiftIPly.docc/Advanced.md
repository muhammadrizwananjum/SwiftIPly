# Advanced Features

### Custom URL Session
```swift
extension IPly {
    static func getPublicIP(using session: URLSession) async throws -> String {
        let (data, _) = try await session.data(from: endpoint)
        return try parseIP(from: data)
    }
}