//
//  SWMetaData.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

import Foundation

public struct SWMetaData<T: SWData>: Codable {
    
    enum CodingKeys: String, CodingKey {
        case url, created, edited
    }
    
    public var url: URL?
    public var created: Date?
    public var edited: Date?
    public var identifier: SWDataCategory?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        created = try? container.dateFromString(.created)
        edited  = try? container.dateFromString(.edited)
        url     = URL(string: try container.decodeString(.url))
        
        guard let identifier = SWDataCategory(T.self) else {
            throw container.SWCustomError("Invalid SWData type \(String(describing: T.self))")
        }
        
        self.identifier = identifier

    }

}
