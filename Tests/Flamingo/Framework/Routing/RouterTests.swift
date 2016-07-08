import XCTest
@testable import Flamingo

class RouterTests: XCTestCase, TestResponding {

  static var allTests: [(String, (RouterTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
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
