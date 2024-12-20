//
//  APISearchTests.swift
//  Holocron
//
//  Created by Chris Spradling on 8/13/19.
//

import XCTest
@testable import Holocron

final class APISearchTests: HolocronTestCase {
    
    static var allTests = {
        return [
            ("testBasicSearch", testBasicSearch)
        ]
        
    }
    
    func testBasicSearch() async {

        do {
            let people = try await api.searchPeople(term: "sky")
            XCTAssertEqual(people.count, 3)
        } catch {
            XCTFail(error.localizedDescription)
        }

    }
    
    func testSearchAll() async {


        do {
            let people = try await api.searchAll(term: "sky")
            XCTAssertEqual(people.count, 4)
        } catch {
            XCTFail(error.localizedDescription)
        }

    }

}
