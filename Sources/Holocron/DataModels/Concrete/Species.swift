//
//  Species.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

import Foundation

public struct Species: SWData {
    public var metaData: SWMetaData<Species>
    
    public var name: String
    @Known public var classification: String?
    public var designation: String
    public var averageHeight: Centimeters?
    public var averageLifespan: StandardYears?
    public var eyeColors: [String]
    public var hairColors: [String]
    public var skinColors: [String]
    @Known public var language: String?
    private var homeworld: SWPageLink?
    private var people: [SWPageLink]
    private var films: [SWPageLink]
        
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
    
    
    func getFilms(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Film>) {
        api.fetchSet(films, completion)
        
    }
    
    func getPeople(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Person>) {
        api.fetchSet(people, completion)
        
    }
    
    func getHomeworld(_ api: SWAPI, _ completion: @escaping SWCompletion<Planet>) {
        guard let homeworld = homeworld else { return completion(.failure(.noData))}
        api.fetchOne(homeworld, completion)
        
    }

}
