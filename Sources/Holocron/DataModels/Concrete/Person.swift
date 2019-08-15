//
//  Person.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

public struct Person: SWData, Identifiable {
    public var metaData: SWMetaData
    
    public var name: String
    public var birthYear: SWYear?
    @Known public var eyeColor: String?
    @Known public var gender: String?
    @Known public var hairColor: String?
    public var height: Centimeters?
    public var mass: Kilograms?
    public var skinColor: String
    private var homeworld: SWPageLink?
    private var films: [SWPageLink]
    private var species: [SWPageLink]
    private var vehicles: [SWPageLink]
    private var starships: [SWPageLink]
    
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
    
    public func getFilms(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Film>) {
        api.fetchSet(films, completion)
        
    }
    
    public func getSpecies(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Species>) {
        api.fetchSet(species, completion)
        
    }
    
    public func getVehicles(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Vehicle>) {
        api.fetchSet(vehicles, completion)
        
    }
    
    public func getStarships(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Starship>) {
        api.fetchSet(starships, completion)
    }
    
    public func getHomeworld(_ api: SWAPI, _ completion: @escaping SWCompletion<Planet>) {
        guard let homeworld = homeworld else { return completion(.failure(.noData)) }
        api.fetchOne(homeworld, completion)
        
    }
    
}
