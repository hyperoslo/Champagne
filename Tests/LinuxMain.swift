#if os(Linux)

import XCTest
@testable import FlamingoTestSuite

XCTMain([
  testCase(ApplicationControllerTests.allTests),
  testCase(ApplicationTests.allTests),
  testCase(StatusErrorTests.allTests),
  testCase(ErrorMiddlewareTests.allTests),
  testCase(ParametersMiddlewareTests.allTests)
])

#endif
