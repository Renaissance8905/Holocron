import XCTest
@testable import Holocron

final class APIBatchGetTests: HolocronTestCase {
    
    static var allTests = {
        return [
            ("testGetPeople", testGetPeople),
            ("testGetVehicles", testGetVehicles),
            ("testGetStarships", testGetStarships),
            ("testGetPlanets", testGetPlanets),
            ("testGetFilms", testGetFilms),
            ("testGetSpecies", testGetSpecies)
        ]
            
    }
    
    var limit: Int?
    
    override func setUp() {
        super.setUp()
        self.limit = 10
        
    }
    
    func testGetPeople() {
        
        doAndWait { [weak self] waiter in
            
            self?.api.get(limit: self?.limit) { (data: SWCollectionResult<Person>) in
                switch data {
                case .success(let object):
                    XCTAssertEqual(object.first?.name, "Luke Skywalker")
                    XCTAssertEqual(object.count, self?.limit)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
            }

        }
        
    }
    
    func testGetVehicles() {
        
        doAndWait { [weak self] waiter in
            
            self?.api.get(limit: self?.limit) { (data: SWCollectionResult<Vehicle>) in
                switch data {
                case .success(let object):
                    XCTAssertEqual(object.first?.name, "Sand Crawler")
                    XCTAssertEqual(object.count, self?.limit)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
            }

        }
        
    }
    
    func testGetStarships() {
        
        doAndWait { [weak self] waiter in
            
            self?.api.get(limit: self?.limit) { (data: SWCollectionResult<Starship>) in
                switch data {
                case .success(let object):
                    XCTAssertEqual(object.first?.name, "Executor")
                    XCTAssertEqual(object.count, self?.limit)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
            }

        }
        
    }
    
    func testGetPlanets() {
        
        doAndWait { [weak self] waiter in
            
            self?.api.get(limit: self?.limit) { (data: SWCollectionResult<Planet>) in
                switch data {
                case .success(let object):
                    XCTAssertEqual(object.first?.name, "Alderaan")
                    XCTAssertEqual(object.count, self?.limit)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
            }

        }
        
    }
    
    func testGetFilms() {
        
        doAndWait { [weak self] waiter in
            
            self?.api.get(limit: self?.limit) { (data: SWCollectionResult<Film>) in
                switch data {
                case .success(let object):
                    XCTAssertEqual(object.first?.name, "A New Hope")
                    XCTAssertEqual(object.count, 7) // small data set
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
            }

        }
        
    }
    
    func testGetSpecies() {
        
        doAndWait { [weak self] waiter in
            
            self?.api.get(limit: self?.limit) { (data: SWCollectionResult<Species>) in
                switch data {
                case .success(let object):
                    XCTAssertEqual(object.count, self?.limit)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
                waiter.fulfill()
            }

        }
        
    }
    
    func testGetEverything() {
        doAndWait { [weak self] (waiter) in
            self?.api.getAll { result in
                
                switch result {
                    
                case .success(let items):
                    XCTAssertEqual(items.count, 268)
                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                    
                }
                
                waiter.fulfill()
                
            }
            
        }
        
    }
    
}


