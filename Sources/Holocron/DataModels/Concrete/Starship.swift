//
//  Starship.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

public struct Starship: SWVehicleType, Identifiable {
    public let metaData: SWMetaData
     
    public let name: String
    public let model: String
    public let length: Meters?
    public let costInCredits: Int?
    public let crew: Int?
    public let passengers: Int?
    public let maxAtmospheringSpeed: Int?
    public let cargoCapacity: Kilograms?
    public let consumables: String
    internal let films: [SWPageLink]
    internal let pilots: [SWPageLink]
    
    public let starshipClass: String
    public let hyperdriveRating: String
    public let MGLT: Double?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        metaData = try SWMetaData(from: decoder)
        
        name                    = try container.decodeString(.name)
        model                   = try container.decodeString(.model)
        length                  = Meters(try container.decodeString(.length))
        costInCredits           = Int(try container.decodeString(.costInCredits))
        crew                    = Int(try container.decodeString(.crew))
        passengers              = Int(try container.decodeString(.passengers))
        maxAtmospheringSpeed    = Int(try container.decodeString(.maxAtmospheringSpeed))
        cargoCapacity           = Kilograms(try container.decodeString(.cargoCapacity))
        consumables             = try container.decodeString(.consumables)
        films                   = try container.decode([SWPageLink].self, forKey: .films)
        pilots                  = try container.decode([SWPageLink].self, forKey: .pilots)
        
        starshipClass           = try container.decodeString(.starshipClass)
        hyperdriveRating        = try container.decodeString(.hyperdriveRating)
        MGLT                    = Double(try container.decodeString(.MGLT))
        
    }
    
    public func getFilms(_ api: SWAPI) async throws -> [Film] {
        try await api.fetchSet(films)
    }
    
    public func getPilots(_ api: SWAPI) async throws -> [Person] {
        try await api.fetchSet(pilots)
    }

}
