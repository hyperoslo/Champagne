/**
  Application configuration.
*/
public class Config {

  /// Root directory.
  public let root: String

  /// Server host.
  public var host = "0.0.0.0"

  /// Server port.
  public var port = 8080

  /// Application environment.
  public var environment: Environment = Environment("development")

  public var server: Server.Type = WebServer.self

  /// Bubble schemes.
  var bubbleSchemes = [BubbleScheme]()

  /// Kernel scheme.
  var kernelScheme = KernelScheme(name: "App")

  /// Path to the public web directory.
  public var webDir: String {
    return absolutize(path: "Web")
  }

  /**
    Creates a new `Config` instance.

    - Parameter root: Application root directory.
  */
  public init(root: String = "/") {
    self.root = root
  }

  /**
    Builds absolute path based on the given relative path.

    - Parameter path: Relative path.
    - Returns: AAbsolute path.
  */
  public func absolutize(path: String) -> String {
    return "\(root)/\(path)"
  }
}
