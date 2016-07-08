import PathKit

/**
  Helper class to resolve assets path.
*/
public class AssetProvider {

  /// Project scheme.
  let config: Config

  // MARK: - Initialization

  /**
    Creates a new instance of `AssetProvider`.

    - Parameter config: Application config.
  */
  public init(config: Config) {
    self.config = config
  }

  /**
    Resolves absolute path for the given relative asset path.

    - Parameter asset: Relative asset path.
    - Returns: Absolute asset path.
  */
  public func absolutePathFor(asset string: String) -> Path? {
    var path: Path?
    let kernalPath = Path(
      config.absolutize(path: config.kernelScheme.dir.assets + "/" + string))

    if kernalPath.exists {
      path = kernalPath
    }

    for scheme in bubbleSchemes(with: string) {
      let bubblePath = Path(config.absolutize(path: scheme.dir.assets + "/" + string))

      if bubblePath.exists {
        path = bubblePath
      }
    }

    return path
  }

  /**
    Resolves absolute path for the given relative web reqource path.

    - Parameter web: Relative web resource path.
    - Returns: Absolute web resource path.
  */
  public func absolutePathFor(web string: String) -> Path? {
    var path: Path?
    let webPath = Path(config.webDir + "/" + string)

    if webPath.exists {
      path = webPath
    }

    let kernalPath = Path(
      config.absolutize(path: config.kernelScheme.dir.web + "/" + string))

    if kernalPath.exists {
      path = kernalPath
    }

    for scheme in bubbleSchemes(with: string) {
      let bubblePath = Path(config.absolutize(path: scheme.dir.web + "/" + string))

      if bubblePath.exists {
        path = bubblePath
      }
    }

    return path
  }

  /**
    Resolves a `BubbleScheme` based on the given route path.

    - Parameter string: Route path.
    - Returns: Resolved `BubbleScheme` if found.
  */
  func bubbleSchemes(with string: String) -> [BubbleScheme] {
    guard var name = string.split(separator: "/").first else {
      return []
    }

    if name == string {
      name = ""
    }

    return config.bubbleSchemes.filter({ $0.routePrefix == name })
  }
}
