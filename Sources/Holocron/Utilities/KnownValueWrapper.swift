//
//  KnownValueWrapper.swift
//  Holocron
//
//  Created by Chris Spradling on 8/12/19.
//

@propertyWrapper public struct Known: Codable, Sendable {

    private var value: String?
    
    public init(wrappedValue initialValue: String?) {
        value = initialValue.ifKnown
        
    }
    
    public var wrappedValue: String? {
        get { return value }
        set { value = newValue.ifKnown }
        
    }
    
}

fileprivate extension Optional where Wrapped == String {
    
    var ifKnown: Wrapped? {
        guard
            let string = self,
            !ValuesForUnknown.contains(string.lowercased())
        else { return nil }
        
        return string
        
    }
    
}

