//
//  UnitDescriptionTests.swift
//  Holocron
//
//  Created by Chris Spradling on 8/14/19.
//


import XCTest
@testable import Holocron

final class UnitDescriptionTest: HolocronTestCase {
        
    static var allTests = {
        return [
            ("testDecimal", testDecimal),
            ("testNoDecimal", testNoDecimal),
            ("testSingular", testSingular)
        ]
    }
    
    func testNoDecimal() {
        let cleanDouble: Double = 5
        
        XCTAssertEqual(cleanDouble.description(.kilometers),    "5 km")
        XCTAssertEqual(cleanDouble.description(.meters),        "5 m")
        XCTAssertEqual(cleanDouble.description(.kilograms),     "5 kg")
        XCTAssertEqual(cleanDouble.description(.standardYears), "5 Standard Years")
        XCTAssertEqual(cleanDouble.description(.standardDays),  "5 Standard Days")
        XCTAssertEqual(cleanDouble.description(.standardHours), "5 Standard Hours")

    }
    
    func testDecimal() {
        let dirtyDouble: Double = 5.1
        
        XCTAssertEqual(dirtyDouble.description(.kilometers),    "5.1 km")
        XCTAssertEqual(dirtyDouble.description(.meters),        "5.1 m")
        XCTAssertEqual(dirtyDouble.description(.kilograms),     "5.1 kg")
        XCTAssertEqual(dirtyDouble.description(.standardYears), "5.1 Standard Years")
        XCTAssertEqual(dirtyDouble.description(.standardDays),  "5.1 Standard Days")
        XCTAssertEqual(dirtyDouble.description(.standardHours), "5.1 Standard Hours")
        
    }
    
    func testSingular() {
        let singleDouble: Double = 1
        XCTAssertEqual(singleDouble.description(.kilometers),    "1 km")
        XCTAssertEqual(singleDouble.description(.meters),        "1 m")
        XCTAssertEqual(singleDouble.description(.kilograms),     "1 kg")
        XCTAssertEqual(singleDouble.description(.standardYears), "1 Standard Year")
        XCTAssertEqual(singleDouble.description(.standardDays),  "1 Standard Day")
        XCTAssertEqual(singleDouble.description(.standardHours), "1 Standard Hour")
        
    }
}
