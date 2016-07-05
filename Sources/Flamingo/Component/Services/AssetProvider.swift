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

    if let scheme = modScheme(with: string) {
      let modPath = Path(scheme.dir.assets + "/" + string)

      if modPath.exists {
        path = modPath
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

    if let scheme = modScheme(with: string) {
      let modPath = Path(scheme.dir.web + "/" + string)

      if modPath.exists {
        path = modPath
      }
    }

    return path
  }

  /**
  */
  func modScheme(with string: String) -> ModScheme? {
    guard let name = string.split(separator: "/").first,
      scheme = config.modSchemes.filter({ $0.routePrefix == name }).first
      else { return nil }

    return scheme
  }
}
