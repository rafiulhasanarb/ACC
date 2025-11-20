//
//  FriendsCacheTestHelpers.swift
//  ACCTests
//
//  Created by Rafiul Hasan on 11/20/25.
//

import Foundation
@testable import ACC

///
/// This `FriendsCache` test helper extension provides fast and reliable ways of stubbing
/// database requests with canned responses to prevent making real database requests during tests.
///
/// It simulates asynchrony by completing the request in a global queue.
/// It also allows observing save commands via the `saveCallback` method.
///

extension FriendsCache {
    
    @MainActor
    static var never: FriendsCache {
        results([])
    }
    
    @MainActor
    static func once(_ friends: [Friend]) -> FriendsCache {
        results([.success(friends)])
    }
    
    @MainActor
    static func once(_ error: Error) -> FriendsCache {
        results([.failure(error)])
    }
    
    @MainActor
    static func saveCallback(
        _ saveCallback: @escaping ([Friend]) -> Void
    ) -> FriendsCache {
        results([], saveCallback)
    }
    
    @MainActor
    static func results(
        _ results: [Result<[Friend], Error>],
        _ saveCallback: @escaping ([Friend]) -> Void = { _ in }
    ) -> FriendsCache {
        var results = results
        return resultBuilder({ results.removeFirst() }, saveCallback)
    }
    
    @MainActor
    static func resultBuilder(
        _ resultBuilder: @escaping () -> Result<[Friend], Error>,
        _ saveCallback: @escaping ([Friend]) -> Void = { _ in }
    ) -> FriendsCache {
        FriendsCacheSpy(resultBuilder: resultBuilder, saveCallback: saveCallback)
    }
    
    @MainActor
    private class FriendsCacheSpy: FriendsCache {
        private let nextResult: () -> Result<[Friend], Error>
        private let saveCallback: ([Friend]) -> Void
        
        init(
            resultBuilder: @escaping () -> Result<[Friend], Error>,
            saveCallback save: @escaping ([Friend]) -> Void
        ) {
            nextResult = resultBuilder
            saveCallback = save
        }
        
        override func loadFriends(completion: @escaping (Result<[Friend], Error>) -> Void) {
            let result = nextResult()
            DispatchQueue.global().async { completion(result) }
        }
        
        override func save(_ newFriends: [Friend]) {
            saveCallback(newFriends)
        }
    }
}
