//
//  UserDefaultsFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Jero Sanchez on 8/12/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class UserDefaultsFeedStore: FeedStore {
	public init() { }
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
		
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		
	}
	
	public func retrieve(completion: @escaping RetrievalCompletion) {
		completion(.empty)
	}
}
