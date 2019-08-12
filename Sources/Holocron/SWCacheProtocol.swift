//
//  SWCacheProtocol.swift
//  Holocron
//
//  Created by Chris Spradling on 8/12/19.
//

import Foundation

protocol SWCache {
    func contains(_ :SWPageLink) -> Bool
    func contains(_ type: SWData.Type, identifier: Int) -> Bool
    
    func object<T>(for: SWPageLink) -> T?
    func object<T:SWData>(_ identifier: Int, ofType type: T.Type) -> T?
    
}
