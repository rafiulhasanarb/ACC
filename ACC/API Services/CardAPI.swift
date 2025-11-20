//
//  CardAPI.swift
//  ACC
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation

class CardAPI {
    static var shared = CardAPI()
    
    /// For demo purposes, this method simulates an API request with a pre-defined response and delay.
    func loadCards(completion: @escaping (Result<[Card], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
            completion(.success([
                Card(id: 1, number: "****-0899", holder: "J. DOE"),
                Card(id: 2, number: "****-6544", holder: "DOE J.")
            ]))
        }
    }
}
