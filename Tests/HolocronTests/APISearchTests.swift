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
            
            self?.api.search(for: "sky") { (data: SWCollectionResult<Person>) in
                
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

}
