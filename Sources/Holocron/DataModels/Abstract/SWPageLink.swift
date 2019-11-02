//
//  SWPageLink.swift
//  Holocron
//
//  Created by Chris Spradling on 8/7/19.
//

import Foundation

struct SWPageLink: Codable {
    let category: SWDataCategory
    let index: Int?
    let url: URL
    let identifier: SWIdentifier
    
    private static func url(type: String, index: Int?) throws -> URL {
        guard var url = URL(string: SWAPIBaseURLString) else { throw SWError.invalidURL }
        url.appendPathComponent(type)
        if let index = index {
            url.appendPathComponent(String(index))
        }
        return url
    }
    
    init(_ identifier: SWIdentifier) throws {
        guard let category = SWDataCategory(rawValue: identifier.type) else {
            throw SWError.invalidURL
        }
        self.category   = category
        self.identifier = identifier
        self.index      = identifier.index
        self.url        = try SWPageLink.url(type: identifier.type, index: identifier.index)
        
    }
    
    init<T:SWData>(_ type: T.Type, index: Int? = nil) throws {
        self.category   = try SWDataCategory(type)
        self.index      = index
        self.url        = try SWPageLink.url(type: category.rawValue, index: index)
        self.identifier = SWIdentifier(type: category.rawValue, index: index)
        
    }
    
    init?(_ string: String) {
        let endpoint = string
            .replacingOccurrences(of: SWAPIBaseURLString, with: "")
            .split(separator: "/")
            .compactMap { String($0) }
        
        guard
            !endpoint.isEmpty,
            let first = endpoint.first,
            let category = SWDataCategory(rawValue: first),
            let url = URL(string: string)
        else { return nil }
        
        self.category   = category
        self.index      = endpoint.count > 1 ? Int(endpoint[1]) : nil
        self.url        = url
        self.identifier = SWIdentifier(type: category.rawValue, index: index)
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        
        guard let page = SWPageLink(string) else {
            throw container.SWCustomError("Improper format for SWPageLink: \(string)")
        }
        
        self = page
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(url.absoluteString)
        
    }
    
    func url(with searchTerm: String?) -> URL {
        
        guard let searchTerm = searchTerm, !searchTerm.isEmpty else { return url }
        
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems = [URLQueryItem(name: "search", value: searchTerm)]
        
        return components?.url ?? url
        
    }
    
}

