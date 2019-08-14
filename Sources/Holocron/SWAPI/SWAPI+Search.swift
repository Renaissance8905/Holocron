//
//  SWAPI+Search.swift
//  Holocron
//
//  Created by Chris Spradling on 8/13/19.
//

import Foundation

public extension SWAPI {
    
    func search<T:SWData>(for term: String, _ completion: @escaping SWCollectionCompletion<T>) {
        
        do {
            let link = try SWPageLink(T.self)
            let url = link.url(with: term)
            
            fetchAll(url, completion: completion)
            
        } catch let error {
            completion(.failure(error as? SWError ?? .responseError(error)))
            
        }
        
    }
    
}
