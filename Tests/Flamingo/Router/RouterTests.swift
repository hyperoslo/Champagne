import XCTest
@testable import Flamingo

class RouterTests: XCTestCase, TestResponding {

  static var allTests: [(String, (RouterTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testDraw", testDraw),
      ("testCompose", testCompose),
      ("testMatch", testMatch),
      ("testRespond", testRespond)
    ]
  }

  let rootPath = "/"
  var router: Router!

  let middleware: [Middleware] = [
    ParametersMiddleware(),
    ErrorMiddleware()
  ]

  let responder = BasicResponder { _ in
    Response(status: .ok, body: Data(""))
  }

  let failResponder = BasicResponder { _ in
    Response(status: .notFound, body: Data(""))
  }

  override func setUp() {
    super.setUp()
    router = Router(path: rootPath, middleware: middleware)
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(router.path, rootPath)
    XCTAssertEqual(router.middleware.count, 2)
    XCTAssertEqual(router.container.path, rootPath)
    XCTAssertTrue(router.container.routes.isEmpty)
  }

  func testDraw() {
    router.container.get("index", responder: responder)
    XCTAssertEqual(router.container.routes.count, 1)

    router.draw { map in
      XCTAssertTrue(self.router.container.routes.isEmpty)

      map.get("test", responder: self.responder)
      map.post("test", responder: self.responder)
      map.fallback(responder: self.failResponder)
    }

    XCTAssertEqual(router.container.routeFor(relativePath: "test")?.path, "/test")
    XCTAssertEqual(router.container.routes.count, 2)
    XCTAssertEqual(router.container.routes.first?.actions.count, 2)
    XCTAssertEqual(router.container.routes.last?.actions.count, 0)

    respond(to: router.container.routes.first?.actions[.get], with: .ok)
    respond(to: router.container.routes.first?.actions[.post], with: .ok)
    respond(to: router.container.routes.last?.fallback, with: .notFound)
  }

  func testCompose() {
    router.container.get("index", responder: responder)
    XCTAssertEqual(router.container.routes.count, 1)

    router.compose { map in
      XCTAssertFalse(self.router.container.routes.isEmpty)

      map.get("test", responder: self.responder)
      map.post("test", responder: self.responder)
      map.fallback(responder: self.failResponder)
    }

    XCTAssertEqual(router.container.routeFor(relativePath: "test")?.path, "/test")
    XCTAssertEqual(router.container.routes.count, 3)
    XCTAssertEqual(router.container.routes.first?.actions.count, 1)
    XCTAssertEqual(router.container.routes[1].actions.count, 2)
    XCTAssertEqual(router.container.routes.last?.actions.count, 0)

    respond(to: router.container.routes.first?.actions[.get], with: .ok)
    respond(to: router.container.routes[1].actions[.get], with: .ok)
    respond(to: router.container.routes[1].actions[.post], with: .ok)
    respond(to: router.container.routes.last?.fallback, with: .notFound)
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
