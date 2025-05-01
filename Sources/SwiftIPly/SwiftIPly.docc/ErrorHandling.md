# Error Handling Guide

```swift
import IPly

// Handling specific errors
do {
    let ip = try await IPly.getPublicIP()
} catch IPly.Error.noData {
    print("Server returned no data")
} catch IPly.Error.decodingError {
    print("Invalid server response format")
} catch IPly.Error.networkError(let underlyingError) {
    print("Network failure: \(underlyingError.localizedDescription)")
} catch {
    print("Unknown error: \(error)")
}

// Converting to user messages
extension IPly.Error {
    var userMessage: String {
        switch self {
        case .noData: return "No data received"
        case .decodingError: return "Invalid response format"
        case .networkError: return "Network connection failed"
        case .invalidResponse: return "Server error occurred"
        }
    }
}

// Using in UI
IPly.getPublicIP { result in
    DispatchQueue.main.async {
        switch result {
        case .success(let ip):
            self.ipLabel.text = "Your IP: \(ip)"
        case .failure(let error):
            self.errorLabel.text = error.userMessage
        }
    }
}