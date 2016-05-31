import XCTest
import HTTP
@testable import Flamingo

class ParametersMiddlewareTests: XCTestCase {

  static var allTests: [(String, (ParametersMiddlewareTests) -> () throws -> Void)] {
    return [
      ("testRespondToGetRequest", testRespondToGetRequest),
      ("testRespondToGetRequest", testRespondToGetRequest),
      ("testResolveMethodWithGet", testResolveMethodWithGet),
      ("testResolveMethodWithPost", testResolveMethodWithPost)
    ]
  }

  let middleware = ParametersMiddleware()

  func testRespondToGetRequest() {
    let request = Request(
      method: Request.Method.get,
      uri: URI(path: "/?theme=dark&limit=50"),
      body: Data("")
    )

    let responder: Responder = BasicResponder { request in
      XCTAssertEqual(request.parameters.count, 2)
      XCTAssertEqual(request.parameters["theme"], "dark")
      XCTAssertEqual(request.parameters["limit"], "50")

      return Response(status: .ok)
    }

    try! middleware.respond(to: request, chainingTo: responder)
  }

  func testRespondToPostRequest() {
    let request = Request(
      method: Request.Method.post,
      uri: URI(path: "/"),
      body: Data("theme=dark&bird=flamingo")
    )

    let responder: Responder = BasicResponder { request in
      XCTAssertEqual(request.parameters.count, 2)
      XCTAssertEqual(request.parameters["theme"], "dark")
      XCTAssertEqual(request.parameters["bird"], "flamingo")

      return Response(status: .ok)
    }

    try! middleware.respond(to: request, chainingTo: responder)
  }

  func testResolveMethodWithGet() {
    var request = Request(
      method: Request.Method.get,
      uri: URI(path: "/"),
      body: Data("_method=put")
    )

    let responder: Responder = BasicResponder { request in
      XCTAssertEqual(request.method, Request.Method.get)
      return Response(status: .ok)
    }

    try! middleware.respond(to: request, chainingTo: responder)
  }

  func testResolveMethodWithPost() {
    var request = Request(
      method: Request.Method.post,
      uri: URI(path: "/"),
      body: Data("_method=put")
    )

    let responder: Responder = BasicResponder { request in
      XCTAssertEqual(request.method, Request.Method.put)
      return Response(status: .ok)
    }

    try! middleware.respond(to: request, chainingTo: responder)
  }
}
