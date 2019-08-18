//
//  SWAPI+Get.swift
//  Holocron
//
//  Created by Chris Spradling on 8/13/19.
//

public extension SWAPI {
    
    //
    // MARK: - Fetch All
    //
    
    func getFilms(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Film>) {
        get(limit: limit, completion)
        
    }
    
    func getPeople(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Person>) {
        get(limit: limit, completion)
        
    }

    func getPlanets(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Planet>) {
        get(limit: limit, completion)
        
    }

    func getSpecies(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Species>) {
        get(limit: limit, completion)
        
    }
    
    func getStarships(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Starship>) {
        get(limit: limit, completion)
        
    }

    func getVehicles(limit: Int? = nil, _ completion: @escaping SWCollectionCompletion<Vehicle>) {
        get(limit: limit, completion)
        
    }
    
    //
    // MARK: - Fetch By Identifier
    //
    
    func getFilm(identifier: Int, _ completion: @escaping SWCompletion<Film>) {
        fetchOne(identifier, completion)
        
    }
    
    func getPerson(identifier: Int, _ completion: @escaping SWCompletion<Person>) {
        fetchOne(identifier, completion)
        
    }
    
    func getPlanet(identifier: Int, _ completion: @escaping SWCompletion<Planet>) {
        fetchOne(identifier, completion)
        
    }
    
    func getOneSpecies(identifier: Int, _ completion: @escaping SWCompletion<Species>) {
        fetchOne(identifier, completion)
        
    }
    
    func getStarship(identifier: Int, _ completion: @escaping SWCompletion<Starship>) {
        fetchOne(identifier, completion)
        
    }
    
    func getVehicle(identifier: Int, _ completion: @escaping SWCompletion<Vehicle>) {
        fetchOne(identifier, completion)
        
    }

}
