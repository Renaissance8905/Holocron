//
//  Film.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

import Foundation

public struct Film: SWData {
    var metaData: SWMetaData<Film>
    
    public var name: String { return title }
    
    public var title: String
    public var episodeId: Int
    public var openingCrawl: String
    public var director: String
    public var producer: String
    public var releaseDate: Date
    private var species: [SWPageLink]
    private var vehicles: [SWPageLink]
    private var characters: [SWPageLink]
    private var planets: [SWPageLink]
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        metaData = try SWMetaData(from: decoder)
        
        title           = try container.decodeString(.title)
        episodeId       = try container.decode(Int.self, forKey: .episodeId)
        openingCrawl    = try container.decodeString(.openingCrawl)
        director        = try container.decodeString(.director)
        producer        = try container.decodeString(.producer)
        releaseDate     = try container.dateFromString(.releaseDate, formatter: .dateOnly)
        species         = try container.decode([SWPageLink].self, forKey: .species)
        vehicles        = try container.decode([SWPageLink].self, forKey: .vehicles)
        characters      = try container.decode([SWPageLink].self, forKey: .characters)
        planets         = try container.decode([SWPageLink].self, forKey: .planets)
        
    }
    
    func getSpecies(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Species>) {
        api.fetchSet(species, completion)
        
    }
    
    func getVehicles(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Vehicle>) {
        api.fetchSet(vehicles, completion)
        
    }
    
    func getCharacters(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Person>) {
        api.fetchSet(characters, completion)
        
    }
    
    func getPlanets(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Planet>) {
        api.fetchSet(planets, completion)
        
    }
    
}
