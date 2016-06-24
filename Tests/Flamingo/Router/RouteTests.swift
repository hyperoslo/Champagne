import XCTest
@testable import Flamingo

class RouteTests: XCTestCase, TestResponding {

  static var allTests: [(String, (RouteTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testInitDefaults", testInitDefaults),
      ("testAddAction", testAddAction),
      ("testInitDefaults", testInitDefaults),
      ("testRespondWithAction", testRespondWithAction),
      ("testRespondWithoutAction", testRespondWithoutAction)
    ]
  }

  var route: Route!

  let fallback = BasicResponder { _ in
    Response(status: .notFound)
  }

  let responder = BasicResponder { _ in
    Response(status: .ok, body: Data(""))
  }

  let request = Request(method: .get, uri: URI(path: "/api/v1"))

  override func setUp() {
    super.setUp()
    route = Route(path: "/api/:version")
  }

  // MARK: - Tests

  func testInit() {
    route = Route(
      path: "/api/:version",
      actions: [Method.get: responder],
      fallback: fallback)

    XCTAssertEqual(route.path, "/api/:version")

    respond(to: route.actions[Method.get], with: .ok)
    respond(to: route.fallback, with: .notFound)
  }

  func testInitDefaults() {
    route = Route(path: "/api/:version")

    XCTAssertEqual(route.path, "/api/:version")
    XCTAssertTrue(route.actions.isEmpty)

    respond(to: route.fallback, with: .methodNotAllowed)
  }

  func testAddAction() {
    XCTAssertTrue(route.actions.isEmpty)
    route.addAction(method: .get, action: responder)
    XCTAssertEqual(route.actions.count, 1)

    respond(to: route.actions[Method.get], with: .ok)
  }

  func testRespondWithAction() {
    route.addAction(method: .get, action: responder)

    respond(
      to: BasicResponder { _ in try! self.route.respond(to: self.request) },
      with: .ok
    )
  }

  func testRespondWithoutAction() {
    respond(
      to: BasicResponder { _ in try! self.route.respond(to: self.request) },
      with: .methodNotAllowed
    )
  }
}
