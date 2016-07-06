import PathKit

public class AssetProvider {

  /// Project scheme.
  let config: Config

  // MARK: - Initialization

  /**
  */
  public init(config: Config) {
    self.config = config
  }

  /**
  */
  public func absolutePathFor(asset string: String) -> Path? {
    var path: Path?
    let kernalPath = Path(config.kernelScheme.dir.assets + "/" + string)

    if kernalPath.exists {
      path = kernalPath
    }

    if let scheme = bubbleScheme(with: string) {
      let bubblePath = Path(scheme.dir.assets + "/" + string)

      if bubblePath.exists {
        path = bubblePath
      }
    }

    return path
  }

  /**
  */
  public func absolutePathFor(web string: String) -> Path? {
    var path: Path?
    let webPath = Path(config.webDir + "/" + string)

    if webPath.exists {
      path = webPath
    }

    let kernalPath = Path(config.kernelScheme.dir.web + "/" + string)

    if kernalPath.exists {
      path = kernalPath
    }

    if let scheme = bubbleScheme(with: string) {
      let bubblePath = Path(scheme.dir.web + "/" + string)

      if bubblePath.exists {
        path = bubblePath
      }
    }

    return path
  }

  /**
  */
  func bubbleScheme(with string: String) -> BubbleScheme? {
    guard let name = string.split(separator: "/").first,
      scheme = config.bubbleSchemes.filter({ $0.routePrefix == name }).first
      else { return nil }

    return scheme
  }
}
