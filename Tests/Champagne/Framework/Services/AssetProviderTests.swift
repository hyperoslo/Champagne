import XCTest
@testable import Champagne

class AssetProviderTests: XCTestCase {

  static var allTests: [(String, (AssetProviderTests) -> () throws -> Void)] {
    return [
      ("testAbsolutePathForAsset", testAbsolutePathForAsset),
      ("testAbsolutePathForWeb", testAbsolutePathForWeb),
      ("testBubbleSchemes", testBubbleSchemes)
    ]
  }

  var assetProvider: AssetProvider!

  override func setUp() {
    super.setUp()

    let config = Config(root: Globals.root)
    config.bubbleSchemes = [AppBubble.scheme]

    assetProvider = AssetProvider(config: config)
  }

  // MARK: - Tests

  func testAbsolutePathForAsset() {
    let kernelPath = assetProvider.absolutePathFor(asset: "kernel.txt")
    XCTAssertEqual(kernelPath?.description, "\(Globals.root)/App/Assets/kernel.txt")

    let bubblePath = assetProvider.absolutePathFor(asset: "bubble.txt")
    XCTAssertEqual(
      bubblePath?.description,
      "\(Globals.root)/Bubbles/AppBubble/Assets/bubble.txt"
    )
  }

  func testAbsolutePathForWeb() {
    let globalPath = assetProvider.absolutePathFor(web: "file.txt")
    XCTAssertEqual(globalPath?.description, "\(Globals.root)/Web/file.txt")

    let kernelPath = assetProvider.absolutePathFor(web: "kernel.txt")
    XCTAssertEqual(kernelPath?.description, "\(Globals.root)/App/Web/kernel.txt")

    let bubblePath = assetProvider.absolutePathFor(web: "bubble.txt")
    XCTAssertEqual(
      bubblePath?.description,
      "\(Globals.root)/Bubbles/AppBubble/Web/bubble.txt"
    )
  }

  func testBubbleSchemes() {
    let schemes = assetProvider.bubbleSchemes(with: "file.txt")
    XCTAssertEqual(schemes.count, 1)
  }
}
