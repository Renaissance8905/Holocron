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
    
    func testBasicSearch() {
        
        doAndWait { [weak self] waiter in
            
            self?.api.searchPeople(term: "sky") { data in
                
                switch data {
                case .success(let object):
                    XCTAssertEqual(object.count, 3)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                
                waiter.fulfill()
                
            }
            
        }
        
    }
    
    func testSearchAll() {
        doAndWait { [weak self] (waiter) in
            self?.api.searchAll(term: "sky") { result in
                
                switch result {
                    
                case .success(let items):
                    items.forEach {
                        print($0.name)
                    }
                    XCTAssertEqual(items.count, 4)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                    
                }
                
                waiter.fulfill()
                
            }
            
        }
        
    }

}
