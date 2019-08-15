//
//  Film.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

import Foundation

public struct Film: SWData, Identifiable {
    public var metaData: SWMetaData
    
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
    private var starships: [SWPageLink]
    
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
        starships       = try container.decode([SWPageLink].self, forKey: .starships)
        
    }
    
    public var releaseDateString: String {
        return DateFormatter.dateOnly.string(from: releaseDate)
    }
    
    public func getSpecies(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Species>) {
        api.fetchSet(species, completion)
        
    }
    
    public func getVehicles(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Vehicle>) {
        api.fetchSet(vehicles, completion)
        
    }
    
    public func getCharacters(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Person>) {
        api.fetchSet(characters, completion)
        
    }

    public func getStarships(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Starship>) {
        api.fetchSet(starships, completion)
    }
    
    public func getPlanets(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Planet>) {
        api.fetchSet(planets, completion)
        
    }
    
}
