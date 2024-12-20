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
    
    func testGetPeople() async {

        do {
            let object: [Person] = try await self.api.get(limit: self.limit)
            XCTAssertEqual(object.first?.name, "Luke Skywalker")
            XCTAssertEqual(object.count, self.limit)

        } catch {

            XCTFail(error.localizedDescription)
        }

    }
    
    func testGetVehicles() async {

        do {
            let object: [Vehicle] = try await self.api.get(limit: self.limit)
            XCTAssertEqual(object.first?.name, "Sand Crawler")
            XCTAssertEqual(object.count, self.limit)

        } catch {

            XCTFail(error.localizedDescription)
        }

    }
    
    func testGetStarships() async {

        do {
            let object: [Starship] = try await self.api.get(limit: self.limit)
            XCTAssertEqual(object.first?.name, "CR90 corvette")
            XCTAssertEqual(object.count, self.limit)

        } catch {

            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testGetPlanets() async {

        do {
            let object: [Planet] = try await self.api.get(limit: self.limit)
            XCTAssertEqual(object.first?.name, "Tatooine")
            XCTAssertEqual(object.count, self.limit)

        } catch {

            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testGetFilms() async {

        do {
            let object: [Film] = try await self.api.get(limit: self.limit)
            XCTAssertEqual(object.first?.name, "A New Hope")
            XCTAssertEqual(object.count, 7) // small data set

        } catch {

            XCTFail(error.localizedDescription)
        }

    }
    
    func testGetSpecies() async {

        do {
            let object: [Species] = try await self.api.get(limit: self.limit)
            XCTAssertEqual(object.count, self.limit)

        } catch {

            XCTFail(error.localizedDescription)
        }

    }
    
    func testGetEverything() async {

        do {
            let items: [SWData] = try await self.api.getAll()
            XCTAssertEqual(items.count, 170)

        } catch {

            XCTFail(error.localizedDescription)
        }
        
    }
    
}


