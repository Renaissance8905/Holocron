//
//  SWAPI+Core.swift
//  Holocron
//
//  Created by Chris Spradling on 8/12/19.
//

import Foundation

extension SWAPI {
    
    func get<T:SWData>(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<T>) {
        
        do {
            fetchAll(try SWPageLink(T.self).url, limit: limit, completion: completion)
            
        } catch {
            completion(.failure(.invalidURL))
            
        }
        
    }
    
    func fetchSet<T:SWData>(_ links: [SWPageLink], _ completion: @escaping SWCollectionCompletion<T>) {
        
        guard !links.isEmpty else {
            return completion(.failure(.noData))
        }
        
        let group = DispatchGroup()
        let serial = DispatchQueue(label: "SWAPI.fetchSet.serialQueue")
        
        var resultSet: [T] = []
        var errors: [SWError] = []
        
        links.forEach { (link) in
            
            group.enter()
            
            fetchOne(link) { (result: SWResult<T>) in
                serial.sync {
                    
                    switch result {
                        
                    case .success(let item):
                        resultSet.append(item)
                        
                    case .failure(let error):
                        errors.append(error)
                        
                    }
                    
                    group.leave()

                }
                
            }
            
        }
        
        group.notify(queue: .main) {
            serial.sync {
                
                if let error = errors.first {
                    return completion(.failure(error))
                    
                }
                
                return completion(.success(resultSet))
                
            }
            
        }
        
    }
    
    func fetchOne<T:SWData>(_ link: SWPageLink, _ completion: @escaping SWCompletion<T>) {
        
        if let cached: T = cache?.object(for: link.identifier) {
            return completion(.success(cached))
        }
        
        codableRequest(link.url) { [weak self] (result: SWResult<T>) in
            if case .success(let data) = result { self?.cache?.add(data) }
            completion(result)
        }
        
    }
    
    func fetchOne<T:SWData>(_ index: Int, _ completion: @escaping SWCompletion<T>) {
        do {
            fetchOne(try SWPageLink(T.self, index: index), completion)
            
        } catch let error as SWError {
            completion(.failure(error))
            
        } catch let error {
            completion (.failure(SWError.responseError(error)))
            
        }
        
    }
    
    func fetchAll<T:SWData>(_ url: URL, limit: Int? = nil, existingData: [T] = [], completion: @escaping SWCollectionCompletion<T>) {
        
        codableRequest(url) { [weak self] (result: Result<PaginatableResponse<T>, SWError>) in
            guard let `self` = self else { return }
            
            switch result {
            case .failure(let error):
                completion(.failure(error))
                
            case .success(let response):
                
                let resultSet = existingData + response.results

                switch self.checkLimit(limit, next: response.next, data: resultSet) {

                case .finished(let finalResults):
                    finalResults.forEach { self.cache?.add($0) }
                    return completion(.success(finalResults))

                case .continue(let next):
                    self.fetchAll(next, limit: limit, existingData: resultSet, completion: completion)
                    
                }
                
            }
            
        }
        
    }
    
    func codableRequest<T: Codable>(_ url: URL, completion: @escaping (Result<T, SWError>) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {
                return completion(.failure(.noData))

            }

            if let error = error {
                return completion(.failure(.responseError(error)))

            }

            self?.decode(data, completion)
            
        }.resume()
        
    }
    
    private func decode<T: Codable>(_ data: Data, _ completion: @escaping (Result<T, SWError>) -> Void) {
        
        do {
            completion(.success(try self.decoder.decode(T.self, from: data)))

        } catch let error as DecodingError{
            completion(.failure(.decodingError(error)))

        } catch let error {
            completion(.failure(.responseError(error)))
            
        }

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
