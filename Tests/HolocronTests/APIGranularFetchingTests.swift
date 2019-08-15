import XCTest
@testable import Holocron

final class APIGranularFetchingTests: HolocronTestCase {
    
    static var allTests = {
        return [
            ("testGetSingle", testGetSingle),
            ("testGetSet", testGetSet)            
        ]
            
    }
        
    func testGetSingle() {
        do {
            let link = try SWPageLink(Person.self, index: 9)
            
            doAndWait { [weak self] waiter in
                
                self?.api.fetchOne(link) { (data: SWResult<Person>) in
                    switch data {
                    case .success(let object):
                        XCTAssertEqual(object.name, "Biggs Darklighter")
                        
                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                    }
                    
                    waiter.fulfill()
                    
                }

            }
            
        } catch let error {
            XCTFail(error.localizedDescription)
            
        }
        
    }
    
    func testGetSet() {
        do {
            let link = try SWPageLink(Person.self, index: 1)
            
            doAndWait { [weak self] waiter in
                
                guard let api = self?.api else {
                    XCTFail("No Self")
                    return
                }
                
                api.fetchOne(link) { (data: SWResult<Person>) in
                    switch data {
                    case .success(let object):
                        
                        object.getFilms(api) { (result: SWCollectionResult<Film>) in
                            
                            switch result {
                            case .success(let films):
                                XCTAssertEqual(films.count, 5)
                                
                            case .failure(let error):
                                XCTFail(error.localizedDescription)
                            }

                            waiter.fulfill()

                        }

                    case .failure(let error):
                        XCTFail(error.localizedDescription)
                        
                    }
                    
                }
            
            }

        } catch let error {
            XCTFail(error.localizedDescription)
            
        }
                
    }
    
}
