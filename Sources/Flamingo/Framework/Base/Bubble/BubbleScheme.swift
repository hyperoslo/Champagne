public struct BubbleScheme {

  ///
  public let name: String

  ///
  public let dir: Directory

  ///
  public let routePrefix: String

  /**
  */
  public init(name: String, routePrefix: String = "") {
    self.name = name
    dir = Directory(name: name)

    var route = routePrefix
    route.replace(string: " ", with: "")
    
    self.routePrefix = route.lowercased()
  }

  /**
  */
  public struct Directory {

    ///
    public let root: String

    ///
    public var assets: String {
      return "\(root)/Assets"
    }

    public var views: String {
      return "\(assets)/Views"
    }

    ///
    public var web: String {
      return "\(assets)/Web"
    }

    ///
    public var domain: String {
      return "\(root)/Domain"
    }

    ///
    public var controllers: String {
      return "\(domain)/Controllers"
    }

    ///
    public init(name: String) {

      self.root = "Bubbles/\(name)Bubble"
    }
  }
}
