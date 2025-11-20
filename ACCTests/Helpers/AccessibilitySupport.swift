//
//  AccessibilitySupport.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Darwin
import Foundation

enum AccessibilitySupport {
    static let enable: Void = {
        func loadDylibForSimulator(_ path: String) -> UnsafeMutableRawPointer? {
            var libraryPath = path
            let environment = ProcessInfo.processInfo.environment
            if let simulatorRoot = environment["IPHONE_SIMULATOR_ROOT"] {
                libraryPath = (simulatorRoot as NSString).appendingPathComponent(path)
            }
            return dlopen(libraryPath, RTLD_LOCAL)
        }
        
        let appSupport = loadDylibForSimulator("/System/Library/PrivateFrameworks/AppSupport.framework/AppSupport")
        if appSupport != nil {
            let copySharedResourcesPreferencesDomainForDomain = unsafeBitCast(dlsym(appSupport, "CPCopySharedResourcesPreferencesDomainForDomain"), to: (@convention(c) (CFString) -> CFString?).self)
            
            if let accessibilityDomain = copySharedResourcesPreferencesDomainForDomain("com.apple.Accessibility" as CFString) {
                CFPreferencesSetValue("ApplicationAccessibilityEnabled" as CFString, kCFBooleanTrue, accessibilityDomain, kCFPreferencesAnyUser, kCFPreferencesAnyHost)
            }
        }
        
        let handle = loadDylibForSimulator("/usr/lib/libAccessibility.dylib")
        if handle == nil {
            NSException.raise(.genericException, format: "Could not enable accessibility", arguments: getVaList([]))
        }
        
        let _AXSSetAutomationEnabled = unsafeBitCast(dlsym(handle, "_AXSSetAutomationEnabled"), to: (@convention(c) (Int32) -> Void).self)
        _AXSSetAutomationEnabled(1)
    }()
}
