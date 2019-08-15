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
public typealias Percentage = Double



extension Double {
    
    private var numberFormatter: NumberFormatter {
         let format = NumberFormatter()
          format.numberStyle = .decimal
          format.alwaysShowsDecimalSeparator = false
          format.groupingSeparator = ","
          format.decimalSeparator = "."
          return format
      }
      
    
    var commaDelimited: String {
        return numberFormatter.string(from: NSNumber(value: self)) ?? ""
        
    }

    public enum SWUnit {
        case centimeters
        case meters
        case kilometers
        case kilograms
        case standardYears
        case standardDays
        case standardHours
        case percentage
        case custom(String)
        
        fileprivate func description(for value: Double) -> String {
            return String(format: key(for: value), value.commaDelimited)
            
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
            case .percentage:       return "%@%%"
            case .custom(let unit): return "%@ \(unit)"
                
            }
            
        }
                
    }
    
    fileprivate var isSingular: Bool {
        abs(self - 1.0) < 0.001
        
    }
    
    public func description(_ unit: SWUnit? = nil) -> String {
        return unit?.description(for: self) ?? commaDelimited
        
    }
    
}

public extension Int {
    
    func description(_ unit: Double.SWUnit? = nil) -> String {
        return Double(self).description(unit)
        
    }
    
}
