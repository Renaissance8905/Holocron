//
//  SWAPI+Core.swift
//  Holocron
//
//  Created by Chris Spradling on 8/12/19.
//

import Foundation

extension SWAPI {
    
    func get<T:SWData>(searchTerm: String? = nil, limit: Int? = nil) async throws -> [T] {
        try await fetchAll(
            try SWPageLink(T.self).url(with: searchTerm),
            limit: limit
        )
    }
    
    func fetchSet<T:SWData>(_ links: [SWPageLink]) async throws -> [T] {

        guard !links.isEmpty else {
            throw SWError.noData
        }

        return try await withThrowingTaskGroup(of: T.self, returning: [T].self) { group in
            for link in links {
                group.addTask { try await self.fetchOne(link) }
            }

            var result = [T]()
            for try await task in group {
                result.append(task)
            }
            return result
        }
    }
    
    func fetchOne<T: SWData>(_ link: SWPageLink) async throws -> T {

        if let cached: T = cache?.object(for: link.identifier) {
            return cached
        }

        let response: T = try await codableRequest(link.url)
        self.cache?.add(response)
        return response
    }
    
    func fetchOne<T:SWData>(_ index: Int) async throws -> T {
        try await fetchOne(try SWPageLink(T.self, index: index))
    }
    
    func fetchAll<T:SWData>(_ url: URL, limit: Int? = nil, existingData: [T] = []) async throws -> [T] {

        let response: PaginatableResponse<T> = try await codableRequest(url)

        let resultSet = existingData + response.results

        switch self.checkLimit(limit, next: response.next, data: resultSet) {

        case .finished(let finalResults):
            finalResults.forEach { self.cache?.add($0) }
            return finalResults

        case .continue(let next):
            return try await fetchAll(next, limit: limit, existingData: resultSet)

        }

    }
    
    func codableRequest<T: Codable>(_ url: URL) async throws -> T {
        guard let (data, _) = try? await URLSession.shared.data(from: url) else {
            throw SWError.noData
        }

        return try self.decode(data)
    }
    
    private func decode<T: Codable>(_ data: Data) throws -> T {
        try self.decoder.decode(T.self, from: data)
    }
    
    private enum Progress<T> {
        case `continue`(URL)
        case finished([T])
        
    }
    
    private func checkLimit<T>(_ limit: Int?, next: URL?, data: [T]) -> Progress<T> {
        let resultCount = data.count
        
        guard let limit = limit else {
            guard let next = next else {
                return .finished(data)
                
            }
            
            return .continue(next)
            
        }
                
        let remainder = limit - resultCount
    
        switch remainder {
            
        case _ where remainder < 0:
            return .finished(data.trimmingLast(remainder))
            
        case _ where remainder > 0:
            guard let next = next else { fallthrough }
            return .continue(next)
            
        default:
            return .finished(data)
            
        }
        
    }
    
}
