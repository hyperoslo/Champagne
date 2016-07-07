import XCTest
@testable import Flamingo

class JSONTests: XCTestCase {

  static var allTests: [(String, (JSONTests) -> () throws -> Void)] {
    return [
      ("testInitWithAnyDictionary", testInitWithAnyDictionary),
      ("testInitWithData", testInitWithData),
      ("testInitWithJson", testInitWithJson),
      ("testData", testData),
      ("testJson", testJson)
     ]
  }

  override func setUp() {
    super.setUp()
  }

  // MARK: - Tests

  func testInitWithAnyDictionary() {
    let input: [String: Any] = ["string": "test", "number": 1]

    do {
      let json = try JSON(input)

      switch json {
      case .object(let dictionary):
        XCTAssertEqual(dictionary["string"], "test")
        XCTAssertEqual(
          dictionary["number"],
          JSON.number(JSON.Number.unsignedInteger(1))
        )
      default:
        XCTFail("JSON type is not `.object`")
      }

    } catch {
      XCTFail("JSON initializer throws an error: \(error)")
    }
  }

  func testInitWithData() {
    let data = Data("{\"string\":\"test\",\"number\":\"1\"}")

    do {
      let json = try JSON(data: data)

      switch json {
      case .object(let dictionary):
        XCTAssertEqual(dictionary["string"], "test")
        XCTAssertEqual(
          dictionary["number"],
          JSON.string("1")
        )
      default:
        XCTFail("JSON type is not `.object`")
      }

    } catch {
      XCTFail("JSON initializer throws an error: \(error)")
    }
  }

  func testInitWithJson() {
    let input = JSON.string("test")

    do {
      let json = try JSON(json: input)
      XCTAssertEqual(json, input)
    } catch {
      XCTFail("JSON initializer throws an error: \(error)")
    }
  }

  func testData() {
    let json = JSON.object(["string": "test"])
    let data = Data("{\"string\":\"test\"}")
    XCTAssertEqual(json.data, data)
  }

  func testJson() {
    let json = JSON.string("test")
    XCTAssertEqual(json.json, json)
  }
}
