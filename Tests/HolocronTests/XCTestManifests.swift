import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        APIBatchGetTests.allTests,
        APIGranularFetchingTests.allTests,
        APILimiterTests.allTests
    ]
}
#endif
