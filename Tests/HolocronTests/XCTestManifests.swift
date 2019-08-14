import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        APIBatchGetTests.allTests,
        APIGranularFetchingTests.allTests,
        APILimiterTests.allTests,
        APISearchTests.allTests,
        UnitDescriptionTests.allTests
    ]
}
#endif
