import XCTest
@testable import Holocron

class HolocronTestCase: XCTestCase {
    
    let api = {
        return SWAPI()
    }()
    
    let maxTimeout: TimeInterval = 10.0
    
    func waitOn(_ expectation: XCTestExpectation) {
        wait(for: [expectation], timeout: maxTimeout)
    }
    
    func doAndWait(_ block: @escaping (XCTestExpectation) -> Void) {
        let waiter = expectation(description: "wait for call")
        block(waiter)
        waitOn(waiter)
        
    }
}
