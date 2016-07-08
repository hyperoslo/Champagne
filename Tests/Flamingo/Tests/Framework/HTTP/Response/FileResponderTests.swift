import XCTest
import PathKit
@testable import Flamingo

class FileResponderTests: XCTestCase {

  static var allTests: [(String, (FileResponderTests) -> () throws -> Void)] {
    return [
      ("testRespondToRoot", testRespondToRoot),
      ("testRespondWhenPublicPathIsNotDirectory", testRespondWhenPublicPathIsNotDirectory),
      ("testRespondWhenPublicPathNotExist", testRespondWhenPublicPathNotExist),
      ("testRespondWhenFileNotExist", testRespondWhenFileNotExist),
      ("testRespondWhenFileExists", testRespondWhenFileExists)
    ]
  }

  let responder = FileResponder!

  override func setUp() {
    super.setUp()
    responder = FileResponder(assetProvider: AssetProvider(config: Globals.config))
  }

  // MARK: - Tests

  func testRespondToRoot() {
    let request = Request(
      method: Method.get,
      uri: URI(path: "/")
    )

    do {
      try responder.respond(to: request)
      XCTFail("FileResponder does not throw an error.")
    } catch {
      XCTAssertEqual((error as? StatusError)?.status, Status.notFound)
    }
  }

  func testRespondWhenPublicPathIsNotDirectory() {
    let request = Request(
      method: Method.get,
      uri: URI(path: "/file.txt")
    )

    do {
      try responder.respond(to: request)
      XCTFail("FileResponder does not throw an error.")
    } catch {
      XCTAssertEqual((error as? StatusError)?.status, Status.notFound)
    }
  }

  func testRespondWhenPublicPathNotExist() {
    let request = Request(
      method: Method.get,
      uri: URI(path: "/file.txt")
    )

    do {
      try responder.respond(to: request)
      XCTFail("FileResponder does not throw an error.")
    } catch {
      XCTAssertEqual((error as? StatusError)?.status, Status.notFound)
    }
  }

  func testRespondWhenFileNotExist() {
    let request = Request(
      method: Method.get,
      uri: URI(path: "/test.js")
    )

    do {
      try responder.respond(to: request)
      XCTFail("FileResponder does not throw an error.")
    } catch {
      XCTAssertEqual((error as? StatusError)?.status, Status.notFound)
    }
  }

  func testRespondWhenFileExists() {
    let request = Request(
      method: Method.get,
      uri: URI(path: "/file.txt")
    )

    do {
      let response = try responder.respond(to: request)
      XCTAssertEqual(response.status, Status.ok)
      XCTAssertEqual(response.bodyString, "file\n")
    } catch {
      XCTFail("FileResponder throw an error: \(error)")
    }
  }
}
