//
//  TranfersAPITestHelpers.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation
@testable import ACC

///
/// This `TransfersAPI` test helper extension provides fast and reliable ways of stubbing
/// network requests with canned results to prevent making real network requests during tests.
///
/// It simulates asynchrony by completing the request in a global queue.
///

extension TransfersAPI {
    
    @MainActor
    static func once(_ Transfers: [Transfer]) -> TransfersAPI {
        results([.success(Transfers)])
    }
    
    @MainActor
    static func once(_ error: Error) -> TransfersAPI {
        results([.failure(error)])
    }
    
    @MainActor
    static func results(_ results: [Result<[Transfer], Error>]) -> TransfersAPI {
        var mutableResults = results
        return resultBuilder { mutableResults.removeFirst() }
    }
    
    @MainActor
    static func resultBuilder(_ resultBuilder: @escaping () -> Result<[Transfer], Error>) -> TransfersAPI {
        TransfersAPIStub(resultBuilder: resultBuilder)
    }
    
    @MainActor
    private class TransfersAPIStub: TransfersAPI {
        private let nextResult: () -> Result<[Transfer], Error>
        
        init(resultBuilder: @escaping () -> Result<[Transfer], Error>) {
            nextResult = resultBuilder
        }
        
        override func loadTransfers(completion: @escaping (Result<[Transfer], Error>) -> Void) {
            let result = nextResult()
            DispatchQueue.global().async { completion(result) }
        }
    }
}
