import XCTest
@testable import Champagne

class ContainerTests: XCTestCase {

  static var allTests: [(String, (ContainerTests) -> () throws -> Void)] {
    return [
      ("testRegisterWithProtocol", testRegisterWithProtocol),
      ("testRegisterWithClass", testRegisterWithClass),
      ("testRegisterWithStruct", testRegisterWithStruct),
      ("testHashValue", testHashValue),
      ("testKeyEqual", testKeyEqual),
      ("testKeyNotEqual", testKeyNotEqual)
    ]
  }

  var container: Container!

  override func setUp() {
    super.setUp()
    container = Container()
  }

  // MARK: - Tests

  func testRegisterWithProtocol() {
    container.register(Kernel.self) {
      return AppKernel()
    }

    XCTAssertTrue(container.resolve(Kernel.self) is AppKernel)
    XCTAssertEqual(container.factories.count, 1)

    container.register(Kernel.self, tag: "test") {
      return AppKernel()
    }

    XCTAssertTrue(container.resolve(Kernel.self, tag: "test") is AppKernel)
    XCTAssertEqual(container.factories.count, 2)
  }

  func testRegisterWithClass() {
    container.register(AppKernel.self) {
      return AppKernel()
    }

    XCTAssertNotNil(container.resolve(AppKernel.self))
    XCTAssertEqual(container.factories.count, 1)

    container.register(AppKernel.self, tag: "test") {
      return AppKernel()
    }

    XCTAssertNotNil(container.resolve(AppKernel.self, tag: "test"))
    XCTAssertEqual(container.factories.count, 2)
  }

  func testRegisterWithStruct() {
    container.register(Config.self) {
      return Config(root: "test")
    }

    XCTAssertNotNil(container.resolve(Config.self))
    XCTAssertEqual(container.factories.count, 1)

    container.register(Config.self, tag: "test") {
      return Config(root: "test")
    }

    XCTAssertNotNil(container.resolve(Config.self, tag: "test"))
    XCTAssertEqual(container.factories.count, 2)
  }

  func testHashValue() {
    let key = Container.Key(type: Kernel.self, tag: "test")
    XCTAssertEqual(key.hashValue, String(Kernel.self).hashValue ^ "test".hashValue)
  }

  func testKeyEqual() {
    let key1 = Container.Key(type: Kernel.self, tag: "test")
    let key2 = Container.Key(type: Kernel.self, tag: "test")

    XCTAssertEqual(key1, key2)
  }

  func testKeyNotEqual() {
    let key1 = Container.Key(type: Kernel.self, tag: "test")
    let key2 = Container.Key(type: Kernel.self, tag: "test1")

    XCTAssertNotEqual(key1, key2)
  }
}
