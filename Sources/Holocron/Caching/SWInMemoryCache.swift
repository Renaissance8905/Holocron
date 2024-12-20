//
//  SWInMemoryCache.swift
//  Holocron
//
//  Created by Chris Spradling on 8/15/19.
//

import Foundation

actor SWInMemoryCache: SWCacheProtocol {
    
    static let timeToLive: TimeInterval = 1.days
    
    private let queue = DispatchQueue(label: "SWCache.dictionary.serializer")
    
    private var people      = Cacheable<Person>(SWInMemoryCache.timeToLive)
    private var films       = Cacheable<Film>(SWInMemoryCache.timeToLive)
    private var planets     = Cacheable<Planet>(SWInMemoryCache.timeToLive)
    private var species     = Cacheable<Species>(SWInMemoryCache.timeToLive)
    private var starships   = Cacheable<Starship>(SWInMemoryCache.timeToLive)
    private var vehicles    = Cacheable<Vehicle>(SWInMemoryCache.timeToLive)
    
    func object<T:SWData>(for identifier: SWIdentifier) -> T? {
        queue.sync {
            return getCache(for: identifier)?.object(for: identifier)
            
        }
        
    }
    
    func contains<T: SWData>(_ item: T) -> Bool {
        queue.sync {
            return getCache(for: type(of: item))?.contains(item) == true
            
        }
        
    }
    
    func add<T:SWData>(_ item: T) {
        queue.sync {
            getCache(for: item.metaData.url.identifier)?.add(item)

        }
    }
    
    private func getCache<T:SWData>(for type: T.Type) -> Cacheable<T>? {
        switch type {
        case is Person.Type:    return people as? Cacheable<T>
        case is Film.Type:      return films as? Cacheable<T>
        case is Planet.Type:    return planets as? Cacheable<T>
        case is Species.Type:   return species as? Cacheable<T>
        case is Starship.Type:  return starships as? Cacheable<T>
        case is Vehicle.Type:   return vehicles as? Cacheable<T>
        default:                return nil
            
        }

    }
    
    private func getCache<T:SWData>(for id: SWIdentifier) -> Cacheable<T>? {
        switch id.type.lowercased() {
        case "people":      return people    as? Cacheable<T>
        case "films":       return films     as? Cacheable<T>
        case "planets":     return planets   as? Cacheable<T>
        case "species":     return species   as? Cacheable<T>
        case "starships":   return starships as? Cacheable<T>
        case "vehicles":    return vehicles  as? Cacheable<T>
        default:            return nil
            
        }

    }
    
}
