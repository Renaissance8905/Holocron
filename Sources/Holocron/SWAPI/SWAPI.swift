//
//  SWAPI.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19
//

import Foundation

public class SWAPI {

    internal let cache: SWCache?
    internal let timeout: TimeInterval = 4.0
    
    public init(cache: SWCache? = nil) {
        self.cache = cache
        
    }
    
    internal lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
        
    }()
        
}
