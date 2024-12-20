//
//  Planet.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

public struct Planet: SWData, Identifiable {
    public var metaData: SWMetaData
    
    public var name: String
    public var diameter: Kilometers?
    public var rotationPeriod: StandardHours?
    public var orbitalPeriod: StandardDays?
    public var gravity: String
    public var population: Int?
    public var climate: [String]
    public var terrain: [String]
    public var surfaceWater: Percentage?
    private var residents: [SWPageLink]
    private var films: [SWPageLink]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        metaData = try SWMetaData(from: decoder)
        
        name = try container.decodeString(.name)
        diameter = Kilometers(try container.decodeString(.diameter))
        rotationPeriod = StandardHours(try container.decodeString(.rotationPeriod))
        orbitalPeriod = StandardDays(try container.decodeString(.orbitalPeriod))
        gravity = try container.decodeString(.gravity)
        population = Int(try container.decodeString(.population))
        climate = try container.arrayFromString(.climate)
        terrain = try container.arrayFromString(.terrain)
        surfaceWater = Percentage(try container.decodeString(.surfaceWater))
        residents = try container.decode([SWPageLink].self, forKey: .residents)
        films = try container.decode([SWPageLink].self, forKey: .films)
        
    }
    
    public func getFilms(_ api: SWAPI) async throws -> [Film] {
        try await api.fetchSet(films)

    }
    
    public func getResidents(_ api: SWAPI) async throws -> [Person] {
        try await api.fetchSet(residents)

    }
        
}
