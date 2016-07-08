import XCTest
@testable import Flamingo

class BubbleTests: XCTestCase {

  static var allTests: [(String, (BubbleTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testDraw", testDraw)
    ]
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertTrue(true)
  }

  func testDraw() {
    // router.collection.get("index", responder: responder)
    // XCTAssertEqual(router.collection.routes.count, 1)
    //
    // router.draw { map in
    //   XCTAssertTrue(self.router.collection.routes.isEmpty)
    //
    //   map.get("test", responder: self.responder)
    //   map.post("test", responder: self.responder)
    //   map.fallback(responder: self.failResponder)
    // }
    //
    // XCTAssertEqual(router.collection.routeFor(relativePath: "test")?.path, "/test")
    // XCTAssertEqual(router.collection.routes.count, 2)
    // XCTAssertEqual(router.collection.routes.first?.actions.count, 2)
    // XCTAssertEqual(router.collection.routes.last?.actions.count, 0)
    //
    // respond(to: router.collection.routes.first?.actions[.get], with: .ok)
    // respond(to: router.collection.routes.first?.actions[.post], with: .ok)
    // respond(to: router.collection.routes.last?.fallback, with: .notFound)
  }
}
