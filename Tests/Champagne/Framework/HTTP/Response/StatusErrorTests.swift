import XCTest
@testable import Champagne

class StatusErrorTests: XCTestCase {

  var statusError: StatusError!

  static var allTests: [(String, (StatusErrorTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testMessage", testMessage),
      ("testStatus", testStatus)
    ]
  }

  // MARK: - Tests

  func testInit() {
    let status: Status = .notFound
    statusError = StatusError(status)

    XCTAssertEqual(statusError.status, status)
  }

  func testMessage() {
    let status: Status = .notFound
    let message = "\(status.statusCode) - \(status.reasonPhrase)"

    statusError = StatusError(status)

    XCTAssertEqual(statusError.message, message)
  }

  func testStatus() {
    let status: Status = .notFound
    let statusError = StatusError(status)

    XCTAssertEqual(status, statusError.status)
  }
}
