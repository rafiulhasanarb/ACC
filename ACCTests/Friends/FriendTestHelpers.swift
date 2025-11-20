//
//  FriendTestHelpers.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation
@testable import ACC

///
/// This test helper method provides a way of creating `Friend` models without coupling the
/// tests with the `Friend` initializer. This way, we can change the `Friend` dependencies
/// and initializer without breaking tests (we just need to update the helper method).
///

func aFriend(id: UUID = UUID(), name: String = "any name \(UUID())", phone: String = "any phone \(UUID())") -> Friend {
    Friend(id: id, name: name, phone: phone)
}
