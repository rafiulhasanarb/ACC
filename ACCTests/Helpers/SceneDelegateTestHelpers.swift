//
//  SceneDelegateTestHelpers.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import XCTest
@testable import ACC

extension SceneDelegate {
    static var main: SceneDelegate {
        get throws {
            try XCTUnwrap(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)
        }
    }
}
