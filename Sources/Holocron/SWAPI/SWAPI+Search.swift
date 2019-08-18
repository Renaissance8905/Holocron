//
//  SWAPI+Search.swift
//  Holocron
//
//  Created by Chris Spradling on 8/13/19.
//

import Foundation

public extension SWAPI {
    
    func search<T:SWData>(for term: String, _ completion: @escaping SWCollectionCompletion<T>) {
        
        do {
            let link = try SWPageLink(T.self)
            let url = link.url(with: term)
            
            fetchAll(url, completion: completion)
            
        } catch let error {
            completion(.failure(error as? SWError ?? .responseError(error)))
            
        }
        
    }
    
    func getAll(_ completion: ((Result<[SWData], SWError>) -> Void)?) {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "SWAPI.fetchAll.serialQueue")
        
        var resultSet: [SWData] = []
        var errors: [SWError] = []
        
        func handler<T:SWData>() -> SWCollectionCompletion<T> {
            return { result in
                
                queue.sync {
                    switch result {
                    case .success(let items):
                        resultSet.append(contentsOf: items)
                        
                    case .failure(let error):
                        errors.append(error)
                    }
                    
                    group.leave()
                    
                }
                
            }
            
        }
        
        group.enter()
        getPeople(handler())
        group.enter()
        getFilms(handler())
        group.enter()
        getStarships(handler())
        group.enter()
        getVehicles(handler())
        group.enter()
        getSpecies(handler())
        group.enter()
        getPlanets(handler())
        
        group.notify(queue: .main) {
            queue.sync {
                
                if let error = errors.first {
                    completion?(.failure(error))
                    return
                    
                }
                
                completion?(.success(resultSet))
                return
                
            }
            
        }
        
    }
    
}
