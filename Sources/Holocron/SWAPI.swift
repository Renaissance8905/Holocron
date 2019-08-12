//
//  SWAPI.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19
//

import Foundation

public class SWAPI {

    internal let cache: SWCache?
    
    public init(cache: SWCache? = nil) {
        self.cache = cache
        
    }
    
    internal lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
        
    }()
    
    public func getFilms(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Film>) {
        get(limit: limit, completion)
        
    }
    
    public func getPeople(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Person>) {
        get(limit: limit, completion)
        
    }

    public func getPlanets(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Planet>) {
        get(limit: limit, completion)
        
    }

    public func getSpecies(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Species>) {
        get(limit: limit, completion)
        
    }
    
    public func getStarships(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Starship>) {
        get(limit: limit, completion)
        
    }

    public func getVehicles(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Vehicle>) {
        get(limit: limit, completion)
        
    }
    
    public func getFilm(identifier: Int, _ completion: @escaping SWCompletion<Film>) {
        fetchOne(identifier, completion)
        
    }
    
    public func getPerson(identifier: Int, _ completion: @escaping SWCompletion<Person>) {
        fetchOne(identifier, completion)
        
    }
    
    public func getPlanet(identifier: Int, _ completion: @escaping SWCompletion<Planet>) {
        fetchOne(identifier, completion)
        
    }
    
    public func getSpecies(identifier: Int, _ completion: @escaping SWCompletion<Species>) {
        fetchOne(identifier, completion)
        
    }
    
    public func getStarship(identifier: Int, _ completion: @escaping SWCompletion<Starship>) {
        fetchOne(identifier, completion)
        
    }
    
    public func getVehicle(identifier: Int, _ completion: @escaping SWCompletion<Vehicle>) {
        fetchOne(identifier, completion)
        
    }
    
}
