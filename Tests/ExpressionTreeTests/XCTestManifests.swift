import XCTest

#if !canImport(ObjectiveC)
  public func allTests() -> [XCTestCaseEntry] {
    [
      testCase(ExpressionTreeTests.allTests),
    ]
  }
#endif
