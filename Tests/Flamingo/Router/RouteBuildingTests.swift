import XCTest
@testable import Flamingo

class RouteBuildingTests: XCTestCase {

  static var allTests: [(String, (RouteBuildingTests) -> () throws -> Void)] {
    return [
      ("testRouteForRelativePath", testRouteForRelativePath),
      ("testRouteForAbsolutePath",  testRouteForAbsolutePath)
    ]
  }

  let rootPath = "/"

  let responder = BasicResponder { _ in
    Response(status: .ok, body: Data(""))
  }

  // MARK: - Tests

  func testRouteForRelativePath() {
    let container = RouteContainer(path: rootPath)
    let path = "test"

    container.add(method: .get, path: path, responder: responder)

    XCTAssertNotNil(container.routeFor(relativePath: path))
  }

  func testRouteForAbsolutePath() {
    let container = RouteContainer(path: rootPath)
    let path = "test"

    container.add(method: .get, path: path, responder: responder)

    XCTAssertNotNil(container.routeFor(absolutePath: "\(rootPath)/\(path)"))
  }

  func testAbsolutePathFor() {

  }
}
