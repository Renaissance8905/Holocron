//
//  Starship.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

public struct Starship: SWVehicleType {
    public var metaData: SWMetaData<Starship>
     
    public var name: String
    public var model: String
    public var length: Meters
    public var costInCredits: String
    public var crew: String
    public var passengers: String
    public var maxAtmospheringSpeed: String
    public var cargoCapacity: Kilograms?
    public var consumables: String
    internal var films: [SWPageLink]
    internal var pilots: [SWPageLink]
    
    public var starshipClass: String
    public var hyperdriveRating: String
    public var MGLT: String
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        metaData = try SWMetaData(from: decoder)
        
        name                    = try container.decodeString(.name)
        model                   = try container.decodeString(.model)
        length                  = Meters(try container.decodeString(.length))!
        costInCredits           = try container.decodeString(.costInCredits)
        crew                    = try container.decodeString(.crew)
        passengers              = try container.decodeString(.passengers)
        maxAtmospheringSpeed    = try container.decodeString(.maxAtmospheringSpeed)
        cargoCapacity           = Kilograms(try container.decodeString(.cargoCapacity))
        consumables             = try container.decodeString(.consumables)
        films                   = try container.decode([SWPageLink].self, forKey: .films)
        pilots                  = try container.decode([SWPageLink].self, forKey: .pilots)
        
        starshipClass           = try container.decodeString(.starshipClass)
        hyperdriveRating        = try container.decodeString(.hyperdriveRating)
        MGLT                    = try container.decodeString(.MGLT)
        
    }
    
    func getFilms(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Film>) {
        api.fetchSet(films, completion)
        
    }
    
    func getPilots(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Person>) {
        api.fetchSet(pilots, completion)
        
    }

}
