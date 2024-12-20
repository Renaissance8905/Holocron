//
//  Species.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

public struct Species: SWData, Identifiable {
    public let metaData: SWMetaData
    
    public let name: String
    @Known public var classification: String?
    public let designation: String
    public let averageHeight: Centimeters?
    public let averageLifespan: StandardYears?
    public let eyeColors: [String]
    public let hairColors: [String]
    public let skinColors: [String]
    @Known public var language: String?
    private let homeworld: SWPageLink?
    private let people: [SWPageLink]
    private let films: [SWPageLink]
        
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        metaData = try SWMetaData(from: decoder)
        
        name = try container.decodeString(.name)
        classification  = try container.decodeString(.classification)
        designation     = try container.decodeString(.designation)
        averageHeight   = Centimeters(try container.decodeString(.averageHeight))
        averageLifespan = StandardYears(try container.decodeString(.averageLifespan))
        eyeColors       = try container.arrayFromString(.eyeColors)
        hairColors      = try container.arrayFromString(.hairColors)
        skinColors      = try container.arrayFromString(.skinColors)
        language        = try container.decodeString(.language)
        homeworld       = try container.decodeIfPresent(SWPageLink.self, forKey: .homeworld)
        people          = try container.decode([SWPageLink].self, forKey: .people)
        films           = try container.decode([SWPageLink].self, forKey: .films)
        
    }
    
    
    public func getFilms(_ api: SWAPI) async throws -> [Film] {
        try await api.fetchSet(films)
    }
    
    public func getPeople(_ api: SWAPI) async throws -> [Person] {
        try await api.fetchSet(people)
    }
    
    public func getHomeworld(_ api: SWAPI) async throws -> Planet {
        guard let homeworld else { throw SWError.noData }
        return try await api.fetchOne(homeworld)
    }

}
