//
//  Codable+Holocron.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19.
//

import Foundation

extension KeyedDecodingContainer {
        
    func decodeString(_ key: K) throws -> String {
        try decode(String.self, forKey: key)
        
    }
    
    func dateFromString(_ key: K, formatter: DateFormatter = .iso8601) throws -> Date {
        let dateString = try decodeString(key)
        
        guard let date = formatter.date(from: dateString) else {
            throw SWCustomError("Invalid date format for \(key.stringValue): expected \(formatter.dateFormat ?? "[UNDEFINED]"), got \(dateString)")
            
        }
        
        return date
        
    }
    
    func arrayFromString(_ key: K, separator: Character = ",") throws -> [String] {
        let string = try decodeString(key)
        
        return string
            .split(separator: separator)
            .compactMap { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        
    }
    
    func SWCustomError(_ description: String) -> DecodingError {
        return .dataCorrupted(DecodingError.Context(codingPath: codingPath, debugDescription: description))
        
    }
    
}

extension SingleValueDecodingContainer {
    func SWCustomError( _ description: String) -> DecodingError {
        return .dataCorruptedError(in: self, debugDescription: description)
        
    }
    
}
