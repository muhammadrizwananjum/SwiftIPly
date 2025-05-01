//
//  PlatformSupport.swift
//  IPly
//
//  Created by Muhammad Rizwan Anjum on 01/05/2025.
//

import Foundation
import Network

public extension IPly {
    /// Checks for general network availability across supported platforms.
    static var isNetworkAvailable: Bool {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitorQueue")
        var isConnected = false
        
        // This ensures access to isConnected is thread-safe
        let semaphore = DispatchSemaphore(value: 0)

        monitor.pathUpdateHandler = { path in
            // Update isConnected on the main thread
            DispatchQueue.main.async {
                isConnected = path.status == .satisfied
                semaphore.signal() // Signal that the status is updated
            }
        }
        
        monitor.start(queue: queue)
        
        // Wait for the network status update (asynchronously handled)
        semaphore.wait()

        // Return the updated network status
        return isConnected
    }
}
