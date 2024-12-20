//
//  Person.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

public struct Person: SWData, Identifiable {
    public let metaData: SWMetaData
    
    public let name: String
    public let birthYear: SWYear?
    @Known public var eyeColor: String?
    @Known public var gender: String?
    @Known public var hairColor: String?
    public let height: Centimeters?
    public let mass: Kilograms?
    public let skinColor: String
    private let homeworld: SWPageLink?
    private let films: [SWPageLink]
    private let species: [SWPageLink]
    private let vehicles: [SWPageLink]
    private let starships: [SWPageLink]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        metaData = try SWMetaData(from: decoder)
        
        name        = try container.decodeString(.name)
        birthYear   = try? container.decode(SWYear.self, forKey: .birthYear)
        eyeColor    = try container.decodeString(.eyeColor)
        gender      = try container.decodeString(.gender)
        hairColor   = try container.decodeString(.hairColor)
        height      = Centimeters(try container.decodeString(.height))
        mass        = Kilograms(try container.decodeString(.mass))
        skinColor   = try container.decodeString(.skinColor)
        homeworld   = try container.decode(SWPageLink.self, forKey: .homeworld)
        films       = try container.decode([SWPageLink].self, forKey: .films)
        species     = try container.decode([SWPageLink].self, forKey: .species)
        vehicles    = try container.decode([SWPageLink].self, forKey: .vehicles)
        starships   = try container.decode([SWPageLink].self, forKey: .starships)
        
    }
    
    public func getFilms(_ api: SWAPI) async throws -> [Film] {
        try await api.fetchSet(films)

    }
    
    public func getSpecies(_ api: SWAPI) async throws -> [Species] {
        try await api.fetchSet(species)

    }
    
    public func getVehicles(_ api: SWAPI) async throws -> [Vehicle] {
        try await api.fetchSet(vehicles)

    }
    
    public func getStarships(_ api: SWAPI) async throws -> [Starship] {
        try await api.fetchSet(starships)
    }
    
    public func getHomeworld(_ api: SWAPI) async throws -> Planet {
        guard let homeworld else { throw SWError.noData }
        return try await api.fetchOne(homeworld)
        
    }
    
}
