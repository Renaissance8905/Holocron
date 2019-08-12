//
//  PaginatableResponse.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19.
//

import Foundation

struct PaginatableResponse<T: SWData>: Codable {
    var count: Int
    var next: URL?
    var previous: URL?
    var results: [T]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        count = try container.decode(Int.self, forKey: .count)
        next = URL(string: try container.decodeIfPresent(String.self, forKey: .next) ?? "")
        previous = URL(string: try container.decodeIfPresent(String.self, forKey: .previous) ?? "")
        results = try container.decode([T].self, forKey: .results)
        
    }
    
    func results(trimmingLast trim: Int) -> [T] {
        let maxIndex = max(min(results.count + trim, results.count), 0)
        return Array(results.prefix(maxIndex))
        
    }
    
    mutating func addExisting(_ existingData: [T]) {
        results = existingData + results
    }
    
}
