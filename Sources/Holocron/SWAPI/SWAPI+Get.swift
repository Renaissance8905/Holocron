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
    
    func getFilms(limit: Int? = nil) async throws -> [Film] {
        try await get(limit: limit)
    }
    
    func getPeople(limit: Int? = nil) async throws -> [Person] {
        try await get(limit: limit)
    }

    func getPlanets(limit: Int? = nil) async throws -> [Planet] {
        try await get(limit: limit)
    }

    func getSpecies(limit: Int? = nil) async throws -> [Species] {
        try await get(limit: limit)
    }
    
    func getStarships(limit: Int? = nil) async throws -> [Starship] {
        try await get(limit: limit)
    }

    func getVehicles(limit: Int? = nil) async throws -> [Vehicle] {
        try await get(limit: limit)
    }
    
    //
    // MARK: - Fetch By Identifier
    //
    
    func getFilm(identifier: Int) async throws -> Film {
        try await fetchOne(identifier)
    }
    
    func getPerson(identifier: Int) async throws -> Person {
        try await fetchOne(identifier)
    }
    
    func getPlanet(identifier: Int) async throws -> Planet {
        try await fetchOne(identifier)
    }
    
    func getOneSpecies(identifier: Int) async throws -> Species {
        try await fetchOne(identifier)
    }
    
    func getStarship(identifier: Int) async throws -> Starship {
        try await fetchOne(identifier)
    }
    
    func getVehicle(identifier: Int) async throws -> Vehicle {
        try await fetchOne(identifier)
    }

}
