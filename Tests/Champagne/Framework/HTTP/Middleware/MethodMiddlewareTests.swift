import XCTest
@testable import Champagne

class MethodMiddlewareTests: XCTestCase {

  static var allTests: [(String, (MethodMiddlewareTests) -> () throws -> Void)] {
    return [
      ("testRespondToGetRequest", testRespondToGetRequest),
      ("testRespondToPostRequest", testRespondToPostRequest)
    ]
  }

  let middleware = MethodMiddleware()

  // MARK: - Tests

  func testRespondToGetRequest() {
    let request = Request(
      method: Method.get,
      uri: URI(path: "/"),
      body: Data("_method=put")
    )

    let responder: Responder = BasicResponder { request in
      XCTAssertEqual(request.method, Method.get)
      return Response(status: .ok)
    }

    do {
      try middleware.respond(to: request, chainingTo: responder)
    } catch {
      XCTFail("ParametersMiddleware throw an error: \(error)")
    }
  }

  func testRespondToPostRequest() {
    var request = Request(
      method: Method.post,
      uri: URI(path: "/"),
      body: Data("_method=put")
    )

    request.parameters["_method"] = "put"

    let responder: Responder = BasicResponder { request in
      XCTAssertEqual(request.method, Method.put)
      return Response(status: .ok)
    }

    do {
      try middleware.respond(to: request, chainingTo: responder)
    } catch {
      XCTFail("ParametersMiddleware throw an error: \(error)")
    }
  }
}
