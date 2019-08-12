//
//  Planet.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

import Foundation

public struct Planet: SWData {
    public var metaData: SWMetaData<Planet>
    
    public var name: String
    public var diameter: String
    public var rotationPeriod: String
    public var orbitalPeriod: String
    public var gravity: String
    public var population: String
    public var climate: String
    public var terrain: String
    public var surfaceWater: String // percentage
    private var residents: [SWPageLink]
    private var films: [SWPageLink]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        metaData = try SWMetaData(from: decoder)
        
        name = try container.decodeString(.name)
        diameter = try container.decodeString(.diameter)
        rotationPeriod = try container.decodeString(.rotationPeriod)
        orbitalPeriod = try container.decodeString(.orbitalPeriod)
        gravity = try container.decodeString(.gravity)
        population = try container.decodeString(.population)
        climate = try container.decodeString(.climate)
        terrain = try container.decodeString(.terrain)
        surfaceWater = try container.decodeString(.surfaceWater)
        residents = try container.decode([SWPageLink].self, forKey: .residents)
        films = try container.decode([SWPageLink].self, forKey: .films)
        
    }
    
    func getFilms(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Film>) {
        api.fetchSet(films, completion)
        
    }
    
    func getResidents(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Person>) {
        api.fetchSet(residents, completion)
        
    }
    
}
