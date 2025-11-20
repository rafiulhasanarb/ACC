//
//  ErrorTestHelpers.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation

struct Timeout: Error {}

func anError() -> Error {
    NSError(localizedDescription: "any error message")
}

extension NSError {
    convenience init(localizedDescription: String) {
        self.init(domain: "Test", code: 0, userInfo: [NSLocalizedDescriptionKey: localizedDescription])
    }
}

extension Locale {
    static var en_US_POSIX: Locale {
        Locale(identifier: "en_US_POSIX")
    }
}
