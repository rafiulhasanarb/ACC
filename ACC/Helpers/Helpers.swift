//
//  Helpers.swift
//  ACC
//
//  Created by Rafiul Hasan on 11/20/25.
//

import UIKit
import Foundation

enum Formatters {
    static var date = DateFormatter()
    static var number = NumberFormatter()
}

extension UIViewController {
    var presenterVC: UIViewController {
        parent?.presenterVC ?? parent ?? self
    }
}

extension DispatchQueue {
    static func mainAsyncIfNeeded(execute work: @escaping () -> Void) {
        if Thread.isMainThread {
            work()
        } else {
            main.async(execute: work)
        }
    }
}
