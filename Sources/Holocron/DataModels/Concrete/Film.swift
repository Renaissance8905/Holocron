//
//  Film.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

import Foundation

public struct Film: SWData, Identifiable {
    public let metaData: SWMetaData
    
    public var name: String { return title }
    
    public let title: String
    public let episodeId: Int
    public let openingCrawl: String
    public let director: [String]
    public let producer: [String]
    public let releaseDate: Date
    private let species: [SWPageLink]
    private let vehicles: [SWPageLink]
    private let characters: [SWPageLink]
    private let planets: [SWPageLink]
    private let starships: [SWPageLink]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        metaData = try SWMetaData(from: decoder)
        
        title           = try container.decodeString(.title)
        episodeId       = try container.decode(Int.self, forKey: .episodeId)
        openingCrawl    = try container.decodeString(.openingCrawl)
        director        = try container.arrayFromString(.director)
        producer        = try container.arrayFromString(.producer)
        releaseDate     = try container.dateFromString(.releaseDate, formatter: .dateOnly)
        species         = try container.decode([SWPageLink].self, forKey: .species)
        vehicles        = try container.decode([SWPageLink].self, forKey: .vehicles)
        characters      = try container.decode([SWPageLink].self, forKey: .characters)
        planets         = try container.decode([SWPageLink].self, forKey: .planets)
        starships       = try container.decode([SWPageLink].self, forKey: .starships)
        
    }

    public var releaseDateString: String {
        return DateFormatter.dateOnly.string(from: releaseDate)

    }

    public func getSpecies(_ api: SWAPI) async throws -> [Species] {
        try await api.fetchSet(species)

    }

    public func getVehicles(_ api: SWAPI) async throws -> [Vehicle] {
        try await api.fetchSet(vehicles)

    }

    public func getCharacters(_ api: SWAPI) async throws -> [Person] {
        try await api.fetchSet(characters)

    }

    public func getStarships(_ api: SWAPI) async throws -> [Starship] {
        try await api.fetchSet(starships)

    }

    public func getPlanets(_ api: SWAPI) async throws -> [Planet] {
        try await api.fetchSet(planets)

    }

}
