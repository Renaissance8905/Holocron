//
//  Utilities.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

public protocol SWData: Codable {
    var name: String { get }
    var metaData: SWMetaData { get }
    
}

@available(iOS 13.0, *)
public extension SWData where Self: Identifiable {
    
    typealias ID = String
    
    var id: String {
        return metaData.identifier
        
    }
    
}



