#if os(Linux)

import XCTest
@testable import FlamingoTestSuite

XCTMain([
  testCase(ApplicationControllerTests.allTests),
  testCase(ApplicationTests.allTests),
  testCase(EnvironmentTests.allTests),
  testCase(StatusErrorTests.allTests),
  testCase(ErrorMiddlewareTests.allTests),
  testCase(ParametersMiddlewareTests.allTests),
  testCase(PathParametersMiddlewareTests.allTests),
  testCase(RequestTests.allTests),
  testCase(MimeTypeTests.allTests),
  testCase(FileResponderTests.allTests),
  testCase(ResponseTests.allTests),
  testCase(RouteBuildingTests.allTests),
  testCase(RouteContainerTests.allTests),
  testCase(RouteMatcherTests.allTests),
  testCase(RouterTests.allTests),
  testCase(RouteTests.allTests),
  testCase(DictionaryExtensionsTests.allTests),
  testCase(EnvTests.allTests),
  testCase(StencilRendererTests.allTests)
])

#endif
