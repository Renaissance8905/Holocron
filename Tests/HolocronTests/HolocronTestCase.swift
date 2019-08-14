import XCTest
@testable import Holocron

class HolocronTestCase: XCTestCase {
    
    let api = {
        return SWAPI()
    }()
    
    let maxTimeout: TimeInterval = 10.0
    
    func doAndWait(_ block: @escaping (XCTestExpectation) -> Void) {
        let waiter = expectation(description: "wait for call")
        block(waiter)
        wait(for: [waiter], timeout: maxTimeout)
        
    }
}
