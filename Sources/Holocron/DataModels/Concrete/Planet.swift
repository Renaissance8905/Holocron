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
    public var climate: String
    public var terrain: [String]
    private var surfaceWater: Double?
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
        climate = try container.decodeString(.climate)
        terrain = try container.arrayFromString(.terrain)
        surfaceWater = Double(try container.decodeString(.surfaceWater))
        residents = try container.decode([SWPageLink].self, forKey: .residents)
        films = try container.decode([SWPageLink].self, forKey: .films)
        
    }
    
    public func getFilms(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Film>) {
        api.fetchSet(films, completion)
        
    }
    
    public func getResidents(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Person>) {
        api.fetchSet(residents, completion)
        
    }
    
    public var percentSurfaceWater: Double {
        return (surfaceWater ?? 0) / 100
        
    }
    
}
