#if os(Linux)

import XCTest
@testable import FlamingoTestSuite

XCTMain([
  // MARK: - StencilBubble
  testCase(StencilEngineTests.allTests),
  testCase(StencilBubbleTests.allTests),

  // MARK: - Framework

  // Base
  testCase(BubbleSchemeTests.allTests),
  testCase(BubbleTests.allTests),
  testCase(KernelSchemeTests.allTests),
  testCase(KernelTests.allTests),
  testCase(ApplicationTests.allTests),

  // Config
  testCase(ConfigTests.allTests),
  testCase(EnvironmentTests.allTests),
  testCase(EnvTests.allTests),

  // Container
  testCase(ContainerTests.allTests),

  // HTTP/Middleware
  testCase(BodyParametersMiddlewareTests.allTests),
  testCase(ErrorMiddlewareTests.allTests),
  testCase(MethodMiddlewareTests.allTests),
  testCase(PathParametersMiddlewareTests.allTests),
  testCase(QueryParametersMiddlewareTests.allTests),

  // HTTP/Request
  testCase(MethodTests.allTests),
  testCase(QueryParameterParserTests.allTests),
  testCase(RequestTests.allTests),

  // HTTP/Response
  testCase(FileResponderTests.allTests),
  testCase(RenderResponseFactoryTests.allTests),
  testCase(ResourceResponseFactoryTests.allTests),
  testCase(ResponseTests.allTests),
  testCase(StatusErrorTests.allTests),

  // HTTP
  testCase(HeadersTests.allTests),
  testCase(MessageTests.allTests),
  testCase(MimeTypeTests.allTests),

  // Routing
  testCase(ControllerTests.allTests),
  testCase(RouteBuildingTests.allTests),
  testCase(RouteCollectionTests.allTests),
  testCase(RouteMatcherTests.allTests),
  testCase(RouterTests.allTests),
  testCase(RouteTests.allTests),

  // Services
  testCase(AssetProviderTests.allTests),
  testCase(BootServiceMapperTests.allTests),

  // Utilities
  testCase(DictionaryExtensionsTests.allTests),
  testCase(JSONTests.allTests),
])

#endif
