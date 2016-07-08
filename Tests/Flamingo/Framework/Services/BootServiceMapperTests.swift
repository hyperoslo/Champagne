import XCTest
@testable import Flamingo

class BootServiceMapperTests: XCTestCase {

  static var allTests: [(String, (BootServiceMapperTests) -> () throws -> Void)] {
    return [
      ("testAddServices", testAddServices)
    ]
  }

  let container = Container()
  var service: BootServiceMapper!

  override func setUp() {
    super.setUp()

    container.register(Config.self) {
      return Config(root: Globals.root)
    }

    service = BootServiceMapper()
  }

  // MARK: - Tests

  func testAddServices() {
    service.addServices(to: container)

    XCTAssertNotNil(container.resolve(AssetProvider.self))
    XCTAssertTrue(container.resolve(Responder.self, tag: "fallback") is FallbackResponder)
    XCTAssertEqual(container.factories.count, 3)
  }
}
