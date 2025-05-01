//
//  PlatformSupport.swift
//  IPly
//
//  Created by Muhammad Rizwan Anjum on 01/05/2025.
//
#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import AppKit
#elseif os(watchOS)
import WatchKit
#endif

public extension IPly {
    static var isNetworkAvailable: Bool {
        #if os(iOS) || os(tvOS)
        return UIApplication.shared.isNetworkActivityIndicatorVisible
        #elseif os(macOS)
        return true // macOS always has network access in sandbox
        #elseif os(watchOS)
        return WKInterfaceDevice.current().isReachable
        #endif
    }
}
