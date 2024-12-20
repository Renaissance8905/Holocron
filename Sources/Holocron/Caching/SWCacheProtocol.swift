//
//  SWCacheProtocol.swift
//  Holocron
//
//  Created by Chris Spradling on 8/12/19.
//

public protocol SWCacheProtocol: AnyObject {
    
    func object<T:SWData>(for identifier: SWIdentifier) -> T?
    func contains<T: SWData>(_ item: T) -> Bool
    func add<T>(_ item: T) where T : SWData
}
