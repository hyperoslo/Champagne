import XCTest
@testable import Champagne

class EnvironmentTests: XCTestCase {

  static var allTests: [(String, (EnvironmentTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testIsProduction", testIsProduction),
      ("testIsDevelopment", testIsDevelopment),
      ("testIsTest", testIsTest),
      ("testDescription", testDescription)
    ]
  }

  // MARK: - Tests

  func testInit() {
    let environment = Environment("development")
    XCTAssertEqual(environment.value, "development")
  }

  func testIsProduction() {
    XCTAssertTrue(Environment("production").isProduction)
    XCTAssertFalse(Environment("development").isProduction)
    XCTAssertFalse(Environment("test").isProduction)
    XCTAssertFalse(Environment("staging").isProduction)
  }

  func testIsDevelopment() {
    XCTAssertTrue(Environment("development").isDevelopment)
    XCTAssertFalse(Environment("production").isDevelopment)
    XCTAssertFalse(Environment("test").isDevelopment)
    XCTAssertFalse(Environment("staging").isDevelopment)
  }

  func testIsTest() {
    XCTAssertTrue(Environment("test").isTest)
    XCTAssertFalse(Environment("development").isTest)
    XCTAssertFalse(Environment("production").isTest)
    XCTAssertFalse(Environment("staging").isTest)
  }

  func testDescription() {
    XCTAssertEqual(Environment("production").description, "production")
    XCTAssertEqual(Environment("development").description, "development")
    XCTAssertEqual(Environment("test").description, "test")
    XCTAssertEqual(Environment("staging").description, "staging")
  }
}
