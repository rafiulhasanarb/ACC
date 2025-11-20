//
//  FriendsAPITestHelpers.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation
@testable import ACC

///
/// This `FriendsAPI` test helper extension provides fast and reliable ways of stubbing
/// network requests with canned results to prevent making real network requests during tests.
///
/// It simulates asynchrony by completing the request in a global queue.
///

extension FriendsAPI {
    
    @MainActor
    static var never: FriendsAPI {
        results([])
    }
    
    @MainActor
    static func once(_ friends: [Friend]) -> FriendsAPI {
        results([.success(friends)])
    }
    
    @MainActor
    static func results(_ results: [Result<[Friend], Error>]) -> FriendsAPI {
        var results = results
        return resultBuilder { results.removeFirst() }
    }
    
    @MainActor
    static func resultBuilder(_ resultBuilder: @escaping () -> Result<[Friend], Error>) -> FriendsAPI {
        FriendsAPIStub(resultBuilder: resultBuilder)
    }
    
    @MainActor
    private class FriendsAPIStub: FriendsAPI {
        private let nextResult: () -> Result<[Friend], Error>
        
        init(resultBuilder: @escaping () -> Result<[Friend], Error>) {
            nextResult = resultBuilder
        }
        
        override func loadFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
            let result = nextResult()
            DispatchQueue.global().async { completion(result) }
        }
    }
}
