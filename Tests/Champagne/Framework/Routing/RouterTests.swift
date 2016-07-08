import XCTest
@testable import Champagne

class RouterTests: XCTestCase, TestResponding {

  static var allTests: [(String, (RouterTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testDraw", testDraw),
      ("testMatch", testMatch),
      ("testRespond", testRespond)
    ]
  }

  var router: Router!

  let middleware: [Middleware] = [
    QueryParametersMiddleware(),
    ErrorMiddleware()
  ]

  let responder = BasicResponder { _ in
    Response(status: .ok, body: Data(""))
  }

  let failResponder = BasicResponder { _ in
    Response(status: .notFound, body: Data(""))
  }

  let collection = RouteCollection(path: "")
  let application = Globals.application
  var fallback: Responder!

  override func setUp() {
    super.setUp()
    fallback = FallbackResponder(container: application.container)
    router = Router(
      collection: collection,
      fallback: fallback,
      middleware: middleware)
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(router.middleware.count, 2)
    XCTAssertTrue(router.collection.routes.isEmpty)
  }

  func testDraw() {
    router.draw { map in
      XCTAssertTrue(self.router.collection.routes.isEmpty)

      map.get("test", responder: self.responder)
      map.post("test", responder: self.responder)
      map.fallback(responder: self.failResponder)
    }

    XCTAssertEqual(router.collection.routeFor(relativePath: "test")?.path, "/test")
    XCTAssertEqual(router.collection.routes.count, 2)
    XCTAssertEqual(router.collection.routes.first?.actions.count, 2)
    XCTAssertEqual(router.collection.routes.last?.actions.count, 0)

    respond(to: router.collection.routes.first?.actions[.get], with: .ok)
    respond(to: router.collection.routes.first?.actions[.post], with: .ok)
    respond(to: router.collection.routes.last?.fallback, with: .notFound)
  }

  func testMatch() {
    router.draw { map in
      map.root(responder: self.responder)
      map.get("api/:version", responder: self.responder)
      map.get("test", responder: self.responder)
      map.post("test", responder: self.responder)
      map.fallback("fail", responder: self.failResponder)
    }

    var route = router.match(Request(method: .get, uri: URI(path: "/")))
    XCTAssertEqual(route?.path, "/")

    route = router.match(Request(method: .get, uri: URI(path: "/api/1")))
    XCTAssertEqual(route?.path, "/api/:version")

    route = router.match(Request(method: .get, uri: URI(path: "/test")))
    XCTAssertEqual(route?.path, "/test")

    route = router.match(Request(method: .post, uri: URI(path: "/test")))
    XCTAssertEqual(route?.path, "/test")

    route = router.match(Request(method: .get, uri: URI(path: "/fail")))
    XCTAssertEqual(route?.path, "/fail")
  }

  func testRespond() {
    router.draw { map in
      map.get("test", responder: self.responder)
    }

    let request = Request(method: .get, uri: URI(path: "/test"))

    do {
      let response = try router.respond(to: request)
      XCTAssertEqual(response.status, Status.ok)
    } catch {
      XCTFail("Router throws an error: \(error)")
    }

    let failRequest = Request(method: .get, uri: URI(path: "/fail"))

    do {
      let response = try router.respond(to: failRequest)
      XCTAssertEqual(response.status, Status.notFound)
    } catch {
      XCTFail("Router throws an error: \(error)")
    }
  }
}
