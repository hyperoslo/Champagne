import XCTest
@testable import Champagne

class RouteBuildingTests: XCTestCase {

  static var allTests: [(String, (RouteBuildingTests) -> () throws -> Void)] {
    return [
      ("testRouteForRelativePath", testRouteForRelativePath),
      ("testRouteForAbsolutePath", testRouteForAbsolutePath),
      ("testAbsolutePathForWithSlashRoot", testAbsolutePathForWithSlashRoot),
      ("testAbsolutePathForWithEmptyRoot", testAbsolutePathForWithEmptyRoot),
      ("testAbsolutePathForWithSlashedNamedRoot", testAbsolutePathForWithSlashedNamedRoot),
      ("testAbsolutePathForWithNamedRoot", testAbsolutePathForWithNamedRoot)
    ]
  }

  var collection: RouteCollection!
  let rootPath = "/"

  let responder = BasicResponder { _ in
    Response(status: .ok, body: Data(""))
  }

  // MARK: - Tests

  func testRouteForRelativePath() {
    collection = RouteCollection(path: rootPath)
    let path = "test"

    collection.get(path, responder: responder)

    XCTAssertNotNil(collection.routeFor(relativePath: path))
  }

  func testRouteForAbsolutePath() {
    collection = RouteCollection(path: rootPath)
    let path = "test"

    collection.get(path, responder: responder)

    XCTAssertNotNil(collection.routeFor(absolutePath: "\(rootPath)\(path)"))
  }

  func testAbsolutePathForWithSlashRoot() {
    collection = RouteCollection(path: "/")

    // 1st case
    collection.appendLeadingSlash = true
    collection.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "/path")

    // 2nd case
    collection.appendLeadingSlash = false
    collection.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "path/")

    // 3rd case
    collection.appendLeadingSlash = false
    collection.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "path")

    // 4th case
    collection.appendLeadingSlash = true
    collection.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "/path/")

  }

  func testAbsolutePathForWithEmptyRoot() {
    collection = RouteCollection(path: "")

    // 1st case
    collection.appendLeadingSlash = true
    collection.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "/path")

    // 2nd case
    collection.appendLeadingSlash = false
    collection.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "path/")

    // 3rd case
    collection.appendLeadingSlash = false
    collection.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "path")

    // 4th case
    collection.appendLeadingSlash = true
    collection.appendTrailingSlash = true

    testScenarios(path: "path", absolutePath: "/path/")
  }

  func testAbsolutePathForWithSlashedNamedRoot() {
    collection = RouteCollection(path: "/name")

    // 1st case
    collection.appendLeadingSlash = true
    collection.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "/name/path")

    // 2nd case
    collection.appendLeadingSlash = false
    collection.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "name/path/")

    // 3rd case
    collection.appendLeadingSlash = false
    collection.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "name/path")

    // 4th case
    collection.appendLeadingSlash = true
    collection.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "/name/path/")
  }

  func testAbsolutePathForWithNamedRoot() {
    collection = RouteCollection(path: "name")

    // 1st case
    collection.appendLeadingSlash = true
    collection.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "/name/path")

    // 2nd case
    collection.appendLeadingSlash = false
    collection.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "name/path/")

    // 3rd case
    collection.appendLeadingSlash = false
    collection.appendTrailingSlash = false
    testScenarios(path: "path", absolutePath: "name/path")

    // 4th case
    collection.appendLeadingSlash = true
    collection.appendTrailingSlash = true
    testScenarios(path: "path", absolutePath: "/name/path/")
  }

  // MARK: - Helpers

  func testScenarios(path: String, absolutePath: String) {
    XCTAssertEqual(collection.absolutePathFor(path), absolutePath)
    XCTAssertEqual(collection.absolutePathFor("/\(path)"), absolutePath)
    XCTAssertEqual(collection.absolutePathFor("\(path)/"), absolutePath)
    XCTAssertEqual(collection.absolutePathFor("/\(path)/"), absolutePath)
  }
}
