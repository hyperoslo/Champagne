/**
  Bubble configuration.
*/
public struct BubbleScheme {

  /// Bubble name.
  public let name: String

  /// Bubble directory structure.
  public let dir: Directory

  /// Route prefix.
  public let routePrefix: String

  /**
    Creates a new instance of `BubbleScheme`.

    - Parameter name: Bubble name.
    - Parameter routePrefix: Route prefix, empty by default.
  */
  public init(name: String, routePrefix: String = "") {
    self.name = name
    dir = Directory(name: name)

    var route = routePrefix
    route.replace(string: " ", with: "")

    self.routePrefix = route.lowercased()
  }

  /**
    Representation of bubble's directoty structure.
  */
  public struct Directory {

    /// Root directory relative path.
    public let root: String

    /// Assets directory relative path.
    public var assets: String {
      return "\(root)/Assets"
    }

    /// Views directory relative path.
    public var views: String {
      return "\(assets)/Views"
    }

    /// Web (public) directory relative path.
    public var web: String {
      return "\(assets)/Web"
    }

    /// Domain directory relative path.
    public var domain: String {
      return "\(root)/Domain"
    }

    /// Controllers directory relative path.
    public var controllers: String {
      return "\(domain)/Controllers"
    }

    /**
      Creates a new instance of `Directory`.

      - Parameter name: Bubble name.
    */
    public init(name: String) {

      self.root = "Bubbles/\(name)Bubble"
    }
  }
}
