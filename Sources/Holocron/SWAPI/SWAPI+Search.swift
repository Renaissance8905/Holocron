//
//  SWAPI+Search.swift
//  Holocron
//
//  Created by Chris Spradling on 8/13/19.
//

import Foundation

public extension SWAPI {
    
    func searchPeople(term: String, _ completion: @escaping SWCollectionCompletion<Person>) {
        get(searchTerm: term, completion)
        
    }
    
    func searchFilms(term: String, _ completion: @escaping SWCollectionCompletion<Film>) {
        get(searchTerm: term, completion)
        
    }
    func searchStarships(term: String, _ completion: @escaping SWCollectionCompletion<Starship>) {
        get(searchTerm: term, completion)
        
    }

    func searchVehicles(term: String, _ completion: @escaping SWCollectionCompletion<Vehicle>) {
        get(searchTerm: term, completion)
        
    }

    func searchSpecies(term: String, _ completion: @escaping SWCollectionCompletion<Species>) {
        get(searchTerm: term, completion)
        
    }

    func searchPlanets(term: String, _ completion: @escaping SWCollectionCompletion<Planet>) {
        get(searchTerm: term, completion)
        
    }
    
    func searchAll(term: String, _ completion: ((Result<[SWData], SWError>) -> Void)?) {

        let group = DispatchGroup()
        let queue = DispatchQueue(label: "SWAPI.searchAll.serialQueue")

        var resultSet: [SWData] = []
        var errors: [SWError] = []

        func handler<T:SWData>() -> SWCollectionCompletion<T> {
            return {
                group.handle(queue, result: $0, &resultSet, errors: &errors)

            }

        }

        group.enter()
        searchPeople(term: term, handler())
        group.enter()
        searchFilms(term: term, handler())
        group.enter()
        searchStarships(term: term, handler())
        group.enter()
        searchVehicles(term: term, handler())
        group.enter()
        searchSpecies(term: term, handler())
        group.enter()
        searchPlanets(term: term, handler())

        
        group.notify(queue: queue) { [weak self] in
            self?.handleCompletion(resultSet, errors, completion)
            
        }

    }
    
    func getAll(_ completion: ((Result<[SWData], SWError>) -> Void)?) {
        let group = DispatchGroup()
        let queue = DispatchQueue(label: "SWAPI.fetchAll.serialQueue")
        
        var resultSet: [SWData] = []
        var errors: [SWError] = []
        
        func handler<T:SWData>() -> SWCollectionCompletion<T> {
            return {
                group.handle(queue, result: $0, &resultSet, errors: &errors)

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
        
        group.notify(queue: queue) { [weak self] in
            self?.handleCompletion(resultSet, errors, completion)
            
        }
        
    }
    
    internal func handleCompletion<T>(_ resultSet: [T], _ errors: [SWError], _ completion: ((Result<[T], SWError>) -> Void)?) {
        if let error = errors.first {
            completion?(.failure(error))
            return

        }

        completion?(.success(resultSet))
        return

    }
    
}
