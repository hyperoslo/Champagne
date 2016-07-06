public protocol Kernel: class, ServiceProvider {

  /// Kernel configuration.
  static var scheme: KernelScheme { get }

  /// Application-specific middleware.
  var middleware: [Middleware] { get }

  /// Application modes.
  var mods: [Mod.Type] { get }
}

extension Kernel {

  var frameworkMods: [Mod.Type] {
    return [
      StencilMod.self
    ]
  }

  /// Application-specific middleware.
  public var middleware: [Middleware] {
    return []
  }

  /**
   Registers services on application container.

   - Parameter container: Application container.
  */
  public func registerServices(on container: Container) throws {}
}
