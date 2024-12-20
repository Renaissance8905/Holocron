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
        
    func testRequestModerateLimit() async {
        let limit: Int? = 24


        do {
            let people = try await api.getPeople(limit: limit)
            XCTAssertEqual(people.count, limit)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testRequestZeroLimit() async {
        let limit: Int? = 0

        do {
            let people = try await api.getPeople(limit: limit)
            XCTAssertEqual(people.count, limit)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testRequestNegativeLimit() async {
        let limit: Int? = -24

        do {
            let people = try await api.getPeople(limit: limit)
            XCTAssertEqual(people.count, 0)
        } catch {
            XCTFail(error.localizedDescription)
        }

    }
    
    func testRequestNilLimit() async {
        let limit: Int? = nil

        do {
            let people = try await api.getPeople(limit: limit)
            XCTAssertEqual(people.count, 87)
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func testRequestCrazyHighLimit() async {
        let limit: Int? = 1000

        do {
            let people = try await api.getPeople(limit: limit)
            XCTAssertEqual(people.count, 87)
        } catch {
            XCTFail(error.localizedDescription)
        }

    }
    
}
