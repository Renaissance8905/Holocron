import XCTest
@testable import Holocron

final class APILimiterTests: HolocronTestCase {
    
    static var allTests = {
        return [
            ("testRequestModerateLimit", testRequestModerateLimit),
            ("testRequestZeroLimit", testRequestZeroLimit),
            ("testRequestNegativeLimit", testRequestNegativeLimit),
            ("testRequestNilLimit", testRequestNilLimit),
            ("testRequestCrazyHighLimit", testRequestCrazyHighLimit)
        ]
            
    }
        
    func testRequestModerateLimit() {
        let limit: Int? = 24
        
        doAndWait { [weak self] waiter in
            
            self?.api.getPeople(limit: limit) { (data) in
                switch data {
                case .success(let people):
                    XCTAssertEqual(people.count, limit)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
                
            }

        }
        
    }
    
    func testRequestZeroLimit() {
        let limit: Int? = 0
        
        doAndWait { [weak self] waiter in
            
            self?.api.getPeople(limit: limit) { (data) in
                switch data {
                case .success(let people):
                    XCTAssertEqual(people.count, limit)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
            }
        }
        
    }
    
    func testRequestNegativeLimit() {
        let limit: Int? = -24
        
        doAndWait { [weak self] waiter in
            
            self?.api.getPeople(limit: limit) { (data) in
                switch data {
                case .success(let people):
                    XCTAssertEqual(people.count, 0)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
            }
            
        }
        
    }
    
    func testRequestNilLimit() {
        let limit: Int? = nil
        
        doAndWait { [weak self] waiter in
            
            self?.api.getPeople(limit: limit) { (data) in
                switch data {
                case .success(let people):
                    XCTAssertEqual(people.count, 87)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
            }

        }
        
    }
    
    func testRequestCrazyHighLimit() {
        let limit: Int? = 1000
        
        doAndWait { [weak self] waiter in

            self?.api.getPeople(limit: limit) { (data) in
                switch data {
                case .success(let people):
                    XCTAssertEqual(people.count, 87)
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
            }

        }
        
    }
    
}
