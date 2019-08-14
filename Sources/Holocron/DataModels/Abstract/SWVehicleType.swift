//
//  SWVehicleType.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19.
//

protocol SWVehicleType: SWData {
    var name: String                    { get }
    var model: String                   { get }
    var length: Meters?                 { get }
    var costInCredits: Int?             { get }
    var crew: Int?                      { get }
    var passengers: Int?                { get }
    var maxAtmospheringSpeed: Int?      { get }
    var cargoCapacity: Kilograms?       { get }
    var consumables: String             { get }
    var films: [SWPageLink]             { get }
    var pilots: [SWPageLink]            { get }
    
}
