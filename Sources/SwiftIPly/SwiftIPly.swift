// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

/// A namespace-like enum representing the public IP address service.
public enum IPly {
    
    /// Represents possible errors that can occur while fetching the public IP address.
    public enum Error: LocalizedError, Sendable {
        /// No data received from the server.
        case noData
        
        /// Failed to decode or parse the response data.
        case decodingError
        
        /// A network-level error occurred. The underlying system error is provided.
        case networkError(underlying: Swift.Error)
        
        /// The server response was invalid (e.g., wrong status code).
        case invalidResponse
        
        /// Human-readable description of the error.
        public var errorDescription: String? {
            switch self {
            case .noData: return "No data received from server"
            case .decodingError: return "Failed to decode response"
            case .networkError(let underlying): return underlying.localizedDescription
            case .invalidResponse: return "Invalid server response"
            }
        }
    }
    
    /// The endpoint used to fetch the public IP address.
    private static let endpoint = URL(string: "https://api.myip.com")!
    
    // MARK: - Modern Async/Await API (Swift 5.5+)

    /// Fetches the user's public IP address using Swift's async/await pattern.
    ///
    /// - Returns: A string representing the public IP address.
    /// - Throws: An `IPly.Error` if the request fails or the response is invalid.
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    public static func getPublicIP() async throws -> String {
        let (data, response) = try await URLSession.shared.data(from: endpoint)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw Error.invalidResponse
        }
        
        return try parseIP(from: data)
    }
    
    // MARK: - Backward-Compatible Completion Handler API

    /// Fetches the user's public IP address using a completion handler for older platforms.
    ///
    /// - Parameter completion: A closure that returns a `Result` containing either the IP address or an `IPly.Error`.
    public static func getPublicIP(completion: @Sendable @escaping (Result<String, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: endpoint) { data, response, error in
            let result: Result<String, Error>
            
            if let error = error {
                result = .failure(.networkError(underlying: error))
            } else if let httpResponse = response as? HTTPURLResponse,
                      !(200..<300).contains(httpResponse.statusCode) {
                result = .failure(.invalidResponse)
            } else if let data = data {
                do {
                    let ip = try parseIP(from: data)
                    result = .success(ip)
                } catch {
                    result = .failure(error as? Error ?? .decodingError)
                }
            } else {
                result = .failure(.noData)
            }
            
            completion(result)
        }
        task.resume()
    }
    
    // MARK: - Private Helpers

    /// Parses the IP address from a JSON data response.
    ///
    /// - Parameter data: The raw JSON data received from the API.
    /// - Returns: A string representing the public IP address.
    /// - Throws: `IPly.Error.decodingError` if the JSON is invalid or the "ip" key is missing.
    private static func parseIP(from data: Data) throws -> String {
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let ip = json["ip"] as? String else {
            throw Error.decodingError
        }
        return ip
    }
}
