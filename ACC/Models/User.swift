//
//  User.swift
//  ACC
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation

struct User {
    static var shared: User?
    
    let id: UUID
    let name: String
    let isPremium: Bool
}
