//
//  UIBarButtonItemTestHelpers.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import UIKit

extension UIBarButtonItem {
    var systemItem: SystemItem? {
        (value(forKey: "systemItem") as? NSNumber).flatMap { SystemItem(rawValue: $0.intValue) }
    }
    
    func simulateTap() {
        (target as? NSObject)?.perform(action)
    }
}
