import XCTest
@testable import Flamingo

class RouteBuildingTests: XCTestCase {

  static var allTests: [(String, (RouteBuildingTests) -> () throws -> Void)] {
    return [
      ("testRouteForRelativePath", testRouteForRelativePath),
      ("testRouteForAbsolutePath",  testRouteForAbsolutePath)
    ]
  }

  var container: RouteContainer!
  let rootPath = "/"

  let responder = BasicResponder { _ in
    Response(status: .ok, body: Data(""))
  }

  // MARK: - Tests

  func testRouteForRelativePath() {
    container = RouteContainer(path: rootPath)
    let path = "test"

    container.get(path, responder: responder)

    XCTAssertNotNil(container.routeFor(relativePath: path))
  }

  func testRouteForAbsolutePath() {
    container = RouteContainer(path: rootPath)
    let path = "test"

    container.get(path, responder: responder)

    XCTAssertNotNil(container.routeFor(absolutePath: "\(rootPath)\(path)"))
  }

  func testAbsolutePathForWithSlashRoot() {
    container = RouteContainer(path: "/")

    // 1st case
    container.appendLeadingSlash = true
    container.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "/path")

    // 2nd case
    container.appendLeadingSlash = false
    container.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "path/")

    // 3rd case
    container.appendLeadingSlash = false
    container.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "path")

    // 4th case
    container.appendLeadingSlash = true
    container.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "/path/")

  }

  func testAbsolutePathForWithEmptyRoot() {
    container = RouteContainer(path: "")

    // 1st case
    container.appendLeadingSlash = true
    container.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "/path")

    // 2nd case
    container.appendLeadingSlash = false
    container.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "path/")

    // 3rd case
    container.appendLeadingSlash = false
    container.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "path")

    // 4th case
    container.appendLeadingSlash = true
    container.appendTrailingSlash = true

    testScenarios(path: "path", absolutePath: "/path/")
  }

  func testAbsolutePathForWithSlashedNamedRoot() {
    container = RouteContainer(path: "/name")

    // 1st case
    container.appendLeadingSlash = true
    container.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "/name/path")

    // 2nd case
    container.appendLeadingSlash = false
    container.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "name/path/")

    // 3rd case
    container.appendLeadingSlash = false
    container.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "name/path")

    // 4th case
    container.appendLeadingSlash = true
    container.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "/name/path/")
  }

  func testAbsolutePathForWithNamedRoot() {
    container = RouteContainer(path: "name")

    // 1st case
    container.appendLeadingSlash = true
    container.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "/name/path")

    // 2nd case
    container.appendLeadingSlash = false
    container.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "name/path/")

    // 3rd case
    container.appendLeadingSlash = false
    container.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "name/path")

    // 4th case
    container.appendLeadingSlash = true
    container.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "/name/path/")
  }

  // MARK: - Helpers

  func testScenarios(path: String, absolutePath: String) {
    XCTAssertEqual(container.absolutePathFor(path), absolutePath)
    XCTAssertEqual(container.absolutePathFor("/\(path)"), absolutePath)
    XCTAssertEqual(container.absolutePathFor("\(path)/"), absolutePath)
    XCTAssertEqual(container.absolutePathFor("/\(path)/"), absolutePath)
  }
}
