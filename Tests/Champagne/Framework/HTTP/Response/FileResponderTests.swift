import XCTest
import PathKit
@testable import Flamingo

class FileResponderTests: XCTestCase {

  static var allTests: [(String, (FileResponderTests) -> () throws -> Void)] {
    return [
      ("testRespondToRoot", testRespondToRoot),
      ("testRespondWhenPublicPathNotExist", testRespondWhenPublicPathNotExist),
      ("testRespondWhenFileNotExist", testRespondWhenFileNotExist),
      ("testRespondWhenFileExists", testRespondWhenFileExists)
    ]
  }

  var responder: FileResponder!


  override func setUp() {
    super.setUp()
    resetPath()
  }

  func resetPath(_ path: String = Globals.root) {
    let config = Config(root: path)
    let assetProvider = AssetProvider(config: config)
    responder = FileResponder(assetProvider: assetProvider)
  }

  // MARK: - Tests

  func testRespondToRoot() {
    resetPath()

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

  func testRespondWhenPublicPathNotExist() {
    resetPath(Globals.root + "/Apps")

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
    resetPath()

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
    resetPath()

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
