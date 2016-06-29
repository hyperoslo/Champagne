import XCTest
@testable import Flamingo

class JSONTests: XCTestCase {

  static var allTests: [(String, (JSONTests) -> () throws -> Void)] {
    return [
      ("testInitWithAnyDictionary", testInitWithAnyDictionary),
      ("testInitWithBool", testInitWithBool),
      ("testInitWithDouble", testInitWithDouble),
      ("testInitWithString", testInitWithString),
      ("testInitWithJSONDictionary", testInitWithJSONDictionary),
      ("testInitWithSignedInteger", testInitWithSignedInteger),
      ("testInitWithUnsignedInteger", testInitWithUnsignedInteger),
      ("testInitWithData", testInitWithData),
      ("testInitWithJson", testInitWithJson),
      ("testData", testData),
      ("testJson", testJson),
      ("testInitWithArrayLiteral", testInitWithArrayLiteral),
      ("testInitWithDictionaryLiteral", testInitWithDictionaryLiteral)
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

  func testInitWithBool() {
    XCTAssertEqual(JSON(true), JSON.boolean(true))
    XCTAssertEqual(JSON(false), JSON.boolean(false))
  }

  func testInitWithDouble() {
    XCTAssertEqual(JSON(2.03), JSON.number(JSON.Number.double(2.03)))
    XCTAssertEqual(JSON(1000.65), JSON.number(JSON.Number.double(1000.65)))
  }

  func testInitWithString() {
    XCTAssertEqual(JSON("Flamingo"), "Flamingo")
    XCTAssertEqual(JSON("foo bar"), "foo bar")
  }

  func testInitWithJSONDictionary() {
    let input: [String: JSON] = ["string": "test", "number": 1]
    let json = JSON(input)

    switch json {
    case .object(let dictionary):
      XCTAssertEqual(dictionary["string"], "test")
      XCTAssertEqual(
        dictionary["number"],
        JSON(1)
      )
    default:
      XCTFail("JSON type is not `.object`")
    }
  }

  func testInitWithSignedInteger() {
    let input: Int32 = 11
    XCTAssertEqual(JSON(input), JSON.number(JSON.Number.integer(11)))
  }

  func testInitWithUnsignedInteger() {
    let input: UInt32 = 11
    XCTAssertEqual(JSON(input), JSON.number(JSON.Number.unsignedInteger(11)))
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
    let input = JSON("test")

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
    let json = JSON("test")
    XCTAssertEqual(json.json, json)
  }

  func testInitWithArrayLiteral() {
    let json = JSON(arrayLiteral: "test1", "test2")

    switch json {
    case .array(let items):
      XCTAssertEqual(items, [JSON](["test1", "test2"]))
    default:
      XCTFail("JSON type is not `.array`")
    }
  }

  func testInitWithDictionaryLiteral() {
    let json = JSON(dictionaryLiteral: ("string", "test"), ("number", 1))

    switch json {
    case .object(let dictionary):
      XCTAssertEqual(dictionary["string"], "test")
      XCTAssertEqual(dictionary["number"], 1)
    default:
      XCTFail("JSON type is not `.object`")
    }
  }
}
