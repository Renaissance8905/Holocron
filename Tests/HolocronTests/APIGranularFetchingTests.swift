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
    
    func testGetSeveralSets() {
        
        doAndWait { [weak self] waiter in
            self?.api.getPeople({ (result) in
                switch result {
                case .success(let people):
                    
                    guard let `self` = self, let anakin = people.first(where: { $0.name == "Anakin Skywalker" }) else {
                        XCTFail("No Anakin?")
                        return
                    }
                    
                    let dispatch = DispatchGroup()
                    
                    var stuff = [SWData]()
                    
                    dispatch.enter()
                    anakin.getFilms(self.api) { result in
                        switch result {
                        case .success(let data):
                            stuff.append(contentsOf: data)
                            dispatch.leave()
                            
                        case .failure(let error):
                            XCTFail(error.localizedDescription)
                            
                        }
                    }

                    dispatch.enter()
                    anakin.getVehicles(self.api) { result in
                        switch result {
                        case .success(let data):
                            stuff.append(contentsOf: data)
                            dispatch.leave()
                            
                        case .failure(let error):
                            XCTFail(error.localizedDescription)
                            
                        }
                    }

                    dispatch.enter()
                    anakin.getStarships(self.api) { result in
                        switch result {
                        case .success(let data):
                            stuff.append(contentsOf: data)
                            dispatch.leave()
                            
                        case .failure(let error):
                            XCTFail(error.localizedDescription)
                            
                        }
                    }

                    dispatch.enter()
                    anakin.getHomeworld(self.api) { result in
                        switch result {
                        case .success(let data):
                            stuff.append(data)
                            dispatch.leave()
                            
                        case .failure(let error):
                            XCTFail(error.localizedDescription)
                            
                        }
                    }
                    
                    dispatch.notify(queue: .main) {
                        XCTAssertEqual(stuff.count, 9)
                        waiter.fulfill()
                    }

                    
                case .failure(let error):
                    XCTFail(error.localizedDescription)
                }
            })
        }
        
    }
    
}
