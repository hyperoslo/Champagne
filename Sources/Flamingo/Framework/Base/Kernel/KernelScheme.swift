/**
*/
public struct KernelScheme {

  ///
  public let name: String

  ///
  public let dir: Directory

  /**
  */
  public init(name: String) {
    self.name = name
    dir = Directory(root: name)
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

    ///
    public var web: String {
      return "\(assets)/Web"
    }

    /**
    */
    public init(root: String) {
      self.root = root
    }
  }
}
