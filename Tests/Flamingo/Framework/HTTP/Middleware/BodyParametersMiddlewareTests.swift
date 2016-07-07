import XCTest
@testable import Flamingo

class BodyParametersMiddlewareTests: XCTestCase {

  static var allTests: [(String, (BodyParametersMiddlewareTests) -> () throws -> Void)] {
    return [
      ("testRespondToGetRequest", testRespondToGetRequest),
      ("testRespondToPostRequest", testRespondToPostRequest)
    ]
  }

  let middleware = BodyParametersMiddleware()

  // MARK: - Tests

  func testRespondToGetRequest() {
    let request = Request(
      method: Method.get,
      uri: URI(path: "/?theme=dark&limit=50"),
      body: Data("")
    )

    let responder: Responder = BasicResponder { request in
      XCTAssertEqual(request.parameters.count, 0)
      return Response(status: .ok)
    }

    do {
      try middleware.respond(to: request, chainingTo: responder)
    } catch {
      XCTFail("BodyParametersMiddleware throw an error: \(error)")
    }
  }

  func testRespondToPostRequest() {
    let request = Request(
      method: Method.post,
      uri: URI(path: "/"),
      body: Data("theme=dark&bird=flamingo")
    )

    let responder: Responder = BasicResponder { request in
      XCTAssertEqual(request.parameters.count, 2)
      XCTAssertEqual(request.parameters["theme"], "dark")
      XCTAssertEqual(request.parameters["bird"], "flamingo")

      return Response(status: .ok)
    }

    do {
      try middleware.respond(to: request, chainingTo: responder)
    } catch {
      XCTFail("BodyParametersMiddleware throw an error: \(error)")
    }
  }
}
