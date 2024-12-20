import XCTest
@testable import Holocron

final class APIGranularFetchingTests: HolocronTestCase {
    
    static var allTests = {
        return [
            ("testGetSingle", testGetSingle),
            ("testGetSet", testGetSet)            
        ]
            
    }
        
    func testGetSingle() async {
        do {
            let link = try SWPageLink(Person.self, index: 9)

            let object: Person = try await self.api.fetchOne(link)
            XCTAssertEqual(object.name, "Biggs Darklighter")
            
        } catch let error {
            XCTFail(error.localizedDescription)
            
        }
        
    }
    
    func testGetSet() async {
        do {
            let link = try SWPageLink(Person.self, index: 1)

            let object: Person = try await self.api.fetchOne(link)
            let films = try await object.getFilms(self.api)
            XCTAssertEqual(films.count, 5)

        } catch let error {
            XCTFail(error.localizedDescription)
            
        }
                
    }
    
    func testGetSeveralSets() async throws {

        let people = try await self.api.getPeople()
        guard let anakin = people.first(where: { $0.name == "Anakin Skywalker" }) else {
            XCTFail("No Anakin?")
            return
        }

        let starships = try await anakin.getStarships(self.api)
        XCTAssertEqual(starships.count, 3)
        let vehicles = try await anakin.getVehicles(self.api)
        XCTAssertEqual(vehicles.count, 2)
        let planets = try await anakin.getHomeworld(self.api)
        XCTAssertEqual(planets.name, "Tatooine")
        let films = try await anakin.getFilms(self.api)
        XCTAssertEqual(films.count, 3)
        let species = try await anakin.getSpecies(self.api)
        XCTAssertEqual(species.count, 1)

    }
    
}
