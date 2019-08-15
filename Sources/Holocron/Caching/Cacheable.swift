//
//  Cacheable.swift
//  Holocron
//
//  Created by Chris Spradling on 8/15/19.
//

import Foundation

class Cacheable<T:SWData> {
    
    private let timeToLive: TimeInterval
    
    init(_ timeToLive: TimeInterval) {
        self.timeToLive = timeToLive
    }
    
    typealias CacheValue<Q:SWData> = (timestamp: Date, object: Q)
    typealias CacheObject<T:SWData> = [SWIdentifier: CacheValue<T>]
    
    private var cache: CacheObject<T> = [:]
    
    private func isExpired(_ date: Date) -> Bool {
        return date + timeToLive < Date()
    }
    
    func object(for identifier: SWIdentifier) -> T? {
        guard let item = cache.first(where: { $0.key == identifier })?.value else { return nil }
        
        guard !isExpired(item.timestamp) else {
            removeValue(item.object)
            return nil
        }
        
        return item.object
        
    }
    
    func contains(_ value: T) -> Bool {
        return cache.keys.contains(value.metaData.url.identifier)
    }
    
    func removeValue(_ value: T) {
        cache.removeValue(forKey: value.metaData.url.identifier)
        
    }
    
    func add(_ value: T) {
        cache[value.metaData.url.identifier] = (Date(), value)
    }
    
}
