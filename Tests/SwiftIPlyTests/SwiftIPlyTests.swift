//
//  IPlyTests.swift
//  IPlyTests
//
//  Created by Muhammad Rizwan Anjum on 01/05/2025.

import XCTest
@testable import SwiftIPly

final class IPlyTests: XCTestCase {
    func testErrorDescriptions() {
        let noData = IPly.Error.noData
        XCTAssertEqual(noData.errorDescription, "No data received from server")
        
        let decoding = IPly.Error.decodingError
        XCTAssertEqual(decoding.errorDescription, "Failed to decode response")
        
        let network = IPly.Error.networkError(underlying: URLError(.notConnectedToInternet))
        XCTAssertNotNil(network.errorDescription)
        
        let invalid = IPly.Error.invalidResponse
        XCTAssertEqual(invalid.errorDescription, "Invalid server response")
    }
    
    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    func testAsyncIPFetch() async {
        do {
            let ip = try await IPly.getPublicIP()
            XCTAssertFalse(ip.isEmpty)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    @MainActor func testCompletionHandlerIPFetch() {
        let expectation = self.expectation(description: "IP Fetch Completion")
        
        IPly.getPublicIP { result in
            switch result {
            case .success(let ip):
                XCTAssertFalse(ip.isEmpty)
            case .failure(let error):
                XCTFail("Unexpected error: \(error)")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
