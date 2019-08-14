//
//  SWYear.swift
//  Holocron
//
//  Created by Chris Spradling on 8/7/19.
//

public enum SWYear: CustomStringConvertible, Codable {
    
    private static let ABYLiteral = "ABY"
    private static let BBYLiteral = "BBY"
    
    case BBY(Double)
    case ABY(Double)
    
    init?(_ stringValue: String) {
        
        guard let year = Double(stringValue.trimmingCharacters(in: .letters)) else { return nil }
        
        let era = String(stringValue.suffix(3))
        
        switch era {
        case SWYear.ABYLiteral: self = .ABY(year)
        case SWYear.BBYLiteral: self = .BBY(year)
        default:                return nil
        }
        
        return
        
    }
    
    public init(doubleValue: Double) {
        self = doubleValue > 0 ? .ABY(doubleValue) : .BBY(doubleValue)
        
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let string = try container.decode(String.self)
        
        if string == "unknown" {
            throw DecodingError.valueNotFound(SWYear.self, DecodingError.Context(codingPath: container.codingPath, debugDescription: "Year value is unknown"))
        }
        guard let year = SWYear(string) else {
            throw container.SWCustomError("Improper String format for SWYear: \(string)")
        }
        
        self = year
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(description)
        
    }
    
    public var absoluteYearFromYavin: Double {
        switch self {
        case .ABY(let year):    return year
        case .BBY(let year):    return 0 - year
            
        }
        
    }
    
    public var era: String {
        switch self {
        case .ABY:  return SWYear.ABYLiteral
        case .BBY:  return SWYear.BBYLiteral
            
        }
        
    }
    
    public var relativeYear: Double {
        switch self {
        case .ABY(let year),
             .BBY(let year): return year
            
        }
        
    }
    
    public var description: String {
        let yearString = relativeYear.truncatingRemainder(dividingBy: 1) == 0
            ? String(format: "%.0f", relativeYear)
            : String(relativeYear)
        
        return "\(yearString) \(era)"
        
    }
    
}

extension SWYear: Comparable {
    
    public static func < (lhs: SWYear, rhs: SWYear) -> Bool {
        return lhs.absoluteYearFromYavin < rhs.absoluteYearFromYavin
        
    }
    
}

extension SWYear: AdditiveArithmetic {
    
    public static func - (lhs: SWYear, rhs: SWYear) -> SWYear {
        return SWYear(doubleValue: lhs.absoluteYearFromYavin - rhs.absoluteYearFromYavin)
        
    }
    
    
    public static func + (lhs: SWYear, rhs: SWYear) -> SWYear {
        return SWYear(doubleValue: lhs.absoluteYearFromYavin + rhs.absoluteYearFromYavin)
        
    }
    
    public static var zero: SWYear {
        return .BBY(0)
        
    }
    
    public static func -= (lhs: inout SWYear, rhs: SWYear) {
        lhs = lhs - rhs
        
    }
    
    public static func += (lhs: inout SWYear, rhs: SWYear) {
        lhs = lhs + rhs

    }
    
}
