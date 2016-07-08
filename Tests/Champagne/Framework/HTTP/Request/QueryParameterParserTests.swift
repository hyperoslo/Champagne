import XCTest
@testable import Champagne

class QueryParameterParserTests: XCTestCase {

  static var allTests: [(String, (QueryParameterParserTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testParse", testParse)
    ]
  }

  let string = "param1=test1&param2=test2"
  var parser: QueryParameterParser!

  override func setUp() {
    super.setUp()
    parser = QueryParameterParser(string: string)
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(parser.string, string)
  }

  func testParse() {
    let parameters = parser.parse()
    XCTAssertEqual(parameters, ["param1": "test1", "param2": "test2"])
  }
}
