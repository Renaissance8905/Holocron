//
//  Vehicle.swift
//  Holocron
//
//  Created by Chris Spradling on 8/8/19.
//

public struct Vehicle: SWVehicleType, Identifiable {
    public var metaData: SWMetaData
     
    public var name: String
    public var model: String
    public var length: Meters?
    public var costInCredits: Int?
    public var crew: Int?
    public var passengers: Int?
    public var maxAtmospheringSpeed: Int?
    public var cargoCapacity: Kilograms?
    public var consumables: String
    internal var films: [SWPageLink]
    internal var pilots: [SWPageLink]
    
    public var vehicleClass: String
    public var manufacturer: String
    
    
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
        
        vehicleClass            = try container.decodeString(.vehicleClass)
        manufacturer            = try container.decodeString(.manufacturer)
        
    }
    
    public func getFilms(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Film>) {
        api.fetchSet(films, completion)
        
    }
    
    public func getPilots(_ api: SWAPI, _ completion: @escaping SWCollectionCompletion<Person>) {
        api.fetchSet(pilots, completion)
        
    }

}
