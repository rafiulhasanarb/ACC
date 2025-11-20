//
//  CardAPITestHelpers.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation
@testable import ACC

///
/// This `CardAPI` test helper extension provides fast and reliable ways of stubbing
/// network requests with canned results to prevent making real network requests during tests.
///
/// It simulates asynchrony by completing the request in a global queue.
///

extension CardAPI {
    
    @MainActor
    static func once(_ cards: [Card]) -> CardAPI {
        results([.success(cards)])
    }
    
    @MainActor
    static func once(_ error: Error) -> CardAPI {
        results([.failure(error)])
    }
    
    @MainActor
    static func results(_ results: [Result<[Card], Error>]) -> CardAPI {
        var results = results
        return resultBuilder { results.removeFirst() }
    }
    
    @MainActor
    static func resultBuilder(_ resultBuilder: @escaping () -> Result<[Card], Error>) -> CardAPI {
        CardAPIStub(resultBuilder: resultBuilder)
    }
    
    @MainActor
    private class CardAPIStub: CardAPI {
        private let nextResult: () -> Result<[Card], Error>
        
        init(resultBuilder: @escaping () -> Result<[Card], Error>) {
            nextResult = resultBuilder
        }
        
        override func loadCards(completion: @escaping (Result<[Card], Error>) -> Void) {
            let result = nextResult()
            DispatchQueue.global().async { completion(result) }
        }
    }
}
