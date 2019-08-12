//
//  Array+Holocron.swift
//  Holocron
//
//  Created by Chris Spradling on 8/9/19.
//


extension Array {
    
    func trimmingLast(_ trim: Int) -> Array {
        let maxIndex = Swift.max(Swift.min(count + trim, count), 0)
        return Array(prefix(maxIndex))

    }
    
}
