import XCTest
@testable import Flamingo

class PathParametersMiddlewareTests: XCTestCase {

  static var allTests: [(String, (PathParametersMiddlewareTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit)
    ]
  }

  var middleware: PathParametersMiddleware!
  let parameters = ["version": "v1"]

  override func setUp() {
    super.setUp()
    middleware = PathParametersMiddleware(parameters: parameters)
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(middleware.parameters, parameters)
  }

  func testRespond() {
    let request = Request(
      method: Method.get,
      uri: URI(path: "/api/v1"),
      body: Data("")
    )

    let responder: Responder = BasicResponder { request in
      XCTAssertEqual(request.pathParameters, self.parameters)
      return Response(status: .ok)
    }

    do {
      try middleware.respond(to: request, chainingTo: responder)
    } catch {
      XCTFail("ParametersMiddleware throw an error: \(error)")
    }
  }
}
