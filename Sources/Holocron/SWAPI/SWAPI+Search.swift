//
//  SWAPI+Search.swift
//  Holocron
//
//  Created by Chris Spradling on 8/13/19.
//

import Foundation

public extension SWAPI {
    
    func searchPeople(term: String) async throws -> [Person] {
        try await get(searchTerm: term)
    }
    
    func searchFilms(term: String) async throws -> [Film] {
        try await get(searchTerm: term)
    }

    func searchStarships(term: String) async throws -> [Starship] {
        try await get(searchTerm: term)
    }

    func searchVehicles(term: String) async throws -> [Vehicle] {
        try await get(searchTerm: term)
    }

    func searchSpecies(term: String) async throws -> [Species] {
        try await get(searchTerm: term)
    }

    func searchPlanets(term: String) async throws -> [Planet] {
        try await get(searchTerm: term)
    }

    @discardableResult
    func searchAll(term: String) async throws -> [SWData] {

        return try await withThrowingTaskGroup(of: [SWData].self, returning: [SWData].self) { group in
            group.addTask { try await self.searchPeople(term: term) as [SWData] }
            group.addTask { try await self.searchFilms(term: term) as [SWData] }
            group.addTask { try await self.searchStarships(term: term) as [SWData] }
            group.addTask { try await self.searchVehicles(term: term) as [SWData] }
            group.addTask { try await self.searchSpecies(term: term) as [SWData] }
            group.addTask { try await self.searchPlanets(term: term) as [SWData] }

            var results = [SWData]()
            for try await task in group {
                results += task
            }
            return results
        }
    }

    @discardableResult
    func getAll() async throws -> [SWData] {

        return try await withThrowingTaskGroup(of: [SWData].self, returning: [SWData].self) { group in
            group.addTask { try await self.getPeople() as [SWData] }
            group.addTask { try await self.getFilms() as [SWData] }
            group.addTask { try await self.getStarships() as [SWData] }
            group.addTask { try await self.getVehicles() as [SWData] }

            var results: [SWData] = []
            for try await task in group {
                results += task
            }
            return results
        }
    }

}
