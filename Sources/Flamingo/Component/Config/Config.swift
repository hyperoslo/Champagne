/**
  Application configuration
*/
public class Config {

  ///
  public var host = "0.0.0.0"

  ///
  public var port = 8080

  ///
  public var environment: Environment = Environment("development")

  ///
  public var root = "/"

  ///
  var modSchemes = [ModScheme]()

  ///
  var kernelScheme = KernelScheme(name: "App")

  ///
  public var webDir: String {
    return absolutize(path: "Web")
  }

  public func absolutize(path: String) -> String {
    return "\(root)/\(path)"
  }
}
