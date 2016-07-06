public protocol Kernel: class, ServiceMapper {

  /// Kernel configuration.
  static var scheme: KernelScheme { get }

  /// Application-specific middleware.
  var middleware: [Middleware] { get }

  /// Application bubbles.
  var bubbles: [Bubble.Type] { get }
}

extension Kernel {

  var frameworkBubbles: [Bubble.Type] {
    return [
      StencilBubble.self
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
  public func addServices(to container: Container) {}
}
