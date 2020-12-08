//
//  UserDefaultsFeedStore.swift
//  FeedStoreChallenge
//
//  Created by Jero Sanchez on 8/12/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class UserDefaultsFeedStore: FeedStore {
	
	private struct Cache: Codable {
		let feed: [CodableFeedImage]
		let timestamp : Date
		
		init (feed: [LocalFeedImage], timestamp: Date) {
			self.feed = feed.map { CodableFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
			self.timestamp = timestamp
		}
		
		var localFeed: [LocalFeedImage] {
			return feed.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
		}
	}

	private struct CodableFeedImage: Codable {
		let id: UUID
		let description: String?
		let location: String?
		let url: URL
		
		init(id: UUID, description: String?, location: String?, url: URL) {
			self.id = id
			self.description = description
			self.location = location
			self.url = url
		}
	}
	
	private let userDefaults = UserDefaults.standard
	
	private let storeKey: String
	
	public init(storeKey: String) {
		self.storeKey = storeKey
	}
	
	public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
	}
	
	public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
		let cache = Cache(feed: feed, timestamp: timestamp)
		if let data = try? JSONEncoder().encode(cache) {
			userDefaults.setValue(data, forKey: storeKey
			)
		}
		completion(nil)
	}
	
	public func retrieve(completion: @escaping RetrievalCompletion) {
		guard let data = userDefaults.data(forKey: storeKey), let cache = try? JSONDecoder().decode(Cache.self, from: data) else {
			return completion(.empty)
		}
		
		completion(.found(feed: cache.localFeed, timestamp: cache.timestamp))
	}
}
