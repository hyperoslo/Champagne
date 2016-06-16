import XCTest
@testable import Flamingo

class EnvTests: XCTestCase {

  static var allTests: [(String, (EnvTests) -> () throws -> Void)] {
    return [
      ("testAdd", testAdd),
      ("testRemove", testRemove),
      ("testContains", testContains)
    ]
  }

  let key = "FLAMINGO_ENV"

  override func setUp() {
    super.setUp()
    Env.remove(key)
  }

  // MARK: - Tests

  func testAdd() {
    XCTAssertNil(Env.value(key))
    Env.add(value: "test", key: key)
    XCTAssertEqual(Env.value(key), "test")
  }

  func testRemove() {
    Env.add(value: "test", key: key)
    XCTAssertEqual(Env.value(key), "test")

    Env.remove(key)
    XCTAssertNil(Env.value(key))
  }

  func testContains() {
    XCTAssertFalse(Env.contains(key))
    Env.add(value: "test", key: key)
    XCTAssertTrue(Env.contains(key))
  }
}
