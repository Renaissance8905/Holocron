//
//  SWDataCategory.swift
//  Holocron
//
//  Created by Chris Spradling on 8/7/19.
//

enum SWDataCategory: String {
    
    case people     = "people"
    case films      = "films"
    case starships  = "starships"
    case vehicles   = "vehicles"
    case species    = "species"
    case planets    = "planets"
    
    var object: SWData.Type {
        switch self {
        case .people:       return Person.self
        case .films:        return Film.self
        case .starships:    return Starship.self
        case .vehicles:     return Vehicle.self
        case .species:      return Species.self
        case .planets:      return Planet.self
            
        }
        
    }
    
    init(_ type: SWData.Type) throws {
        switch type {
        case is Person.Type:    self = .people
        case is Film.Type:      self = .films
        case is Starship.Type:  self = .starships
        case is Vehicle.Type:   self = .vehicles
        case is Species.Type:   self = .species
        case is Planet.Type:    self = .planets
        default:                throw SWError.invalidURL
            
        }
        
    }
    
}

