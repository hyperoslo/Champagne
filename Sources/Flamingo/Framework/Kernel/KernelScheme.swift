/**
  Kernel configuration.
*/
public struct KernelScheme {

  /// Kernel name.
  public let name: String

  /// Bubble directory structure.
  public let dir: Directory

  /**
    Creates a new instance of `KernelScheme`.

    - Parameter name: Kernel name.
  */
  public init(name: String) {
    self.name = name
    dir = Directory(name: name)
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

    /// Web (public) directory relative path.
    public var web: String {
      return "\(root)/Web"
    }

    /**
      Creates a new instance of `Directory`.

      - Parameter name: Kernel name.
    */
    public init(name: String) {
      self.root = name
    }
  }
}
