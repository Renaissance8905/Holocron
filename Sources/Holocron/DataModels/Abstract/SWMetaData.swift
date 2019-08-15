//
//  SWMetaData.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

import Foundation

public struct SWIdentifier: Hashable, Equatable {
    var type: String
    var index: Int?
}

public struct SWMetaData: Codable {
    
    enum CodingKeys: String, CodingKey {
        case url, created, edited
    }
    
    internal var url: SWPageLink
    public var created: Date?
    public var edited: Date?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        created = try? container.dateFromString(.created)
        edited  = try? container.dateFromString(.edited)
        url     = try container.decode(SWPageLink.self, forKey: .url)
        
    }
    
}
