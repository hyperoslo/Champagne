#if os(Linux)

import XCTest
@testable import FlamingoTestSuite

XCTMain([
  testCase(ApplicationControllerTests.allTests),
  testCase(ApplicationTests.allTests),
  testCase(StatusErrorTests.allTests),
  testCase(ErrorMiddlewareTests.allTests),
  testCase(ParametersMiddlewareTests.allTests),
  testCase(RequestTests.allTests),
  testCase(ContentTypeTests.allTests),
  testCase(FileResponderTests.allTests),
  testCase(ResponseTests.allTests),
  testCase(RouteContainerTests.allTests),
  testCase(RouterTests.allTests),
  testCase(StencilRendererTests.allTests),
])

#endif
