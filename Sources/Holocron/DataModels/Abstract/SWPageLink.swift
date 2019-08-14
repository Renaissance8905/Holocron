//
//  SWPageLink.swift
//  Holocron
//
//  Created by Chris Spradling on 8/7/19.
//

import Foundation

struct SWPageLink: Codable {
    let category: SWDataCategory
    let identifier: Int?
    let url: URL
    
    init<T:SWData>(_ type: T.Type, identifier: Int? = nil) throws {
        
        guard
            let category = SWDataCategory(type),
            var url = URL(string: SWAPIBaseURLString)
        else { throw SWError.invalidURL }
        
        url.appendPathComponent(category.rawValue)
        if let id = identifier {
            url.appendPathComponent(String(id))
        }
        
        self.category = category
        self.identifier = identifier
        self.url = url
        
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
        self.identifier = endpoint.count > 1 ? Int(endpoint[1]) : nil
        self.url        = url
        
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
    
    var endpoint: String {
        let category = self.category.rawValue
        guard let id = identifier else {
            return category
        }
        
        return [category, String(id)].joined(separator: "/")
    }
    
    func url(with searchTerm: String) -> URL {
        
        var components = URLComponents(string: url.absoluteString)
        components?.queryItems = [URLQueryItem(name: "search", value: searchTerm)]
        
        return components?.url ?? url
        
    }
    
}

