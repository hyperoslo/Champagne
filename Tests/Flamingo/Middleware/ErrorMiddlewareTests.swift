import XCTest
@testable import Flamingo

class ErrorMiddlewareTests: XCTestCase {

  static var allTests: [(String, (ErrorMiddlewareTests) -> () throws -> Void)] {
    return [
      ("testRespondWithoutError", testRespondWithoutError),
      ("testRespondWithStatusError", testRespondWithStatusError),
      ("testRespondWithOtherError", testRespondWithOtherError)
    ]
  }

  let middleware = ErrorMiddleware()

  let request = Request(
    method: Request.Method.get,
    uri: URI(path: "/"),
    body: Data("")
  )

  // MARK: - Tests

  func testRespondWithoutError() {
    let responder: Responder = BasicResponder { _ in
      return Response(status: .ok)
    }

    do {
      let response = try middleware.respond(to: request, chainingTo: responder)
      XCTAssertEqual(response.status, Status.ok)
    } catch {
      XCTFail("ErrorMiddleware throws an error: \(error)")
    }
  }

  func testRespondWithStatusError() {
    let status: Status = .notFound

    let responder: Responder = BasicResponder { _ in
      throw StatusError(status)
    }

    do {
      let response = try middleware.respond(to: request, chainingTo: responder)
      XCTAssertEqual(response.status, status)
      XCTAssertEqual(response.bodyString, status.error.message)
    } catch {
      XCTFail("ErrorMiddleware throws an error: \(error)")
    }
  }

  func testRespondWithOtherError() {
    let status: Status = .internalServerError

    let responder: Responder = BasicResponder { _ in
      throw TestError()
    }

    do {
      let response = try middleware.respond(to: request, chainingTo: responder)
      XCTAssertEqual(response.status, status)
      XCTAssertEqual(response.bodyString, status.error.message)
    } catch {
      XCTFail("ErrorMiddleware throws an error: \(error)")
    }
  }
}
