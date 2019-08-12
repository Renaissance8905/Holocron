//
//  SWCacheProtocol.swift
//  Holocron
//
//  Created by Chris Spradling on 8/12/19.
//

public protocol SWCache {
    func contains(_ type: SWData.Type, identifier: Int) -> Bool
    func object<T:SWData>(_ identifier: Int, ofType type: T.Type) -> T?
    
}

extension SWCache {
    
    func contains(_ link: SWPageLink) -> Bool {
        guard let id = link.identifier else { return false }
        
        return contains(link.category.object, identifier: id)
        
    }
    
    func object<T: SWData>(for link: SWPageLink) -> T? {
        guard let id = link.identifier else { return nil }
        
        return object(id, ofType: T.self)
        
    }
    
}
