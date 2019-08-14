//
//  Units.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19.
//

import Foundation

public typealias Centimeters = Double
public typealias Meters = Double
public typealias Kilometers = Double
public typealias Kilograms = Double
public typealias StandardYears = Double
public typealias StandardDays = Double
public typealias StandardHours = Double

extension Double {
    
    public enum SWUnit {
        case centimeters
        case meters
        case kilometers
        case kilograms
        case standardYears
        case standardDays
        case standardHours
        
        fileprivate func description(for value: Double) -> String {
            return String(format: key(for: value), value.cleanString)
            
        }
        
        private func key(for value: Double) -> String {
            
            let plural = value.isSingular ? "" : "s"
            
            switch self {
            case .centimeters:      return "%@ cm"
            case .meters:           return "%@ m"
            case .kilometers:       return "%@ km"
            case .kilograms:        return "%@ kg"
            case .standardYears:    return "%@ Standard Year\(plural)"
            case .standardDays:     return "%@ Standard Day\(plural)"
            case .standardHours:    return "%@ Standard Hour\(plural)"

            }
            
        }
                
    }
    
    fileprivate var cleanString: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
        
    }
    
    fileprivate var isSingular: Bool {
        abs(self - 1.0) < 0.001
        
    }
    
    public func description(_ unit: SWUnit? = nil) -> String {
        return unit?.description(for: self) ?? cleanString
        
    }
    
}
