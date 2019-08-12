//
//  SWVehicleType.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19.
//

protocol SWVehicleType: SWData {
    var name: String                    { get }
    var model: String                   { get }
    var length: Meters                  { get }
    var costInCredits: String           { get }
    var crew: String                    { get }
    var passengers: String              { get }
    var maxAtmospheringSpeed: String    { get }
    var cargoCapacity: Kilograms?       { get }
    var consumables: String             { get }
    var films: [SWPageLink]             { get }
    var pilots: [SWPageLink]            { get }
    
}
