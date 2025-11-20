//
//  CardTestHelpers.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation
@testable import ACC
///
/// This test helper method provides a way of creating `Card` models without coupling the
/// tests with the `Card` initializer. This way, we can change the `Card` dependencies
/// and initializer without breaking tests (we just need to update the helper method).
///
func aCard(id: Int = Int.random(in: 1...Int.max), number: String = "any number \(UUID())", holder: String = "any holder \(UUID())") -> Card {
    Card(id: id, number: number, holder: holder)
}
