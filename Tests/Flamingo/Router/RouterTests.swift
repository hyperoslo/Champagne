import XCTest
@testable import Flamingo

class RouterTests: XCTestCase, TestResponding {

  static var allTests: [(String, (RouterTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testDraw", testDraw),
      ("testCompose", testCompose),
      ("testMatch", testMatch),
      ("testRespond", testRespond),
    ]
  }

  let rootPath = "/"
  let path = "test"
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

      map.get(self.path, responder: self.responder)
      map.post(self.path, responder: self.responder)
      map.fallback(responder: self.failResponder)
    }

    XCTAssertEqual(router.container.routeFor(relativePath: path)?.path, "\(rootPath)\(path)")
    XCTAssertEqual(router.container.routes.count, 2)
    XCTAssertEqual(router.container.routes.first?.actions.count, 2)
    XCTAssertEqual(router.container.routes.last?.actions.count, 0)

    respond(to: router.container.routes.first?.actions[.get], with: .ok)
    respond(to: router.container.routes.first?.actions[.post], with: .ok)
    respond(to: router.container.routes.last?.fallback, with: .notFound)
  }

  func testCompose() {

  }

  func testMatch() {

  }

  func testRespond() {
  }
}
