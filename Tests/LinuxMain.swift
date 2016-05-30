#if os(Linux)

import XCTest
@testable import FlamingoTestSuite

XCTMain([
  testCase(ApplicationControllerTests.allTests),
  testCase(ApplicationTests.allTests),
])

#endif
