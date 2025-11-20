//
//  Transfer.swift
//  ACC
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation

struct Transfer: Equatable {
    let id: Int
    let description: String
    let amount: Decimal
    let currencyCode: String
    let sender: String
    let recipient: String
    let isSender: Bool
    let date: Date
}
