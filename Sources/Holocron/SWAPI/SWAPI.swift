//
//  SWAPI.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19
//

import Foundation

public class SWAPI: Sendable {

    internal let cache: SWCacheProtocol?
    internal let timeout: TimeInterval = 4.0
    
    public init(cache: SWCacheProtocol? = nil) {
        self.cache = cache
        
    }
    
    public static let `default`: SWAPI = {
        return SWAPI(cache: SWInMemoryCache())
        
    }()
    
    
    internal lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
        
    }()
        
}
