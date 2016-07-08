/**
  A `Bubble` is an entry point of your application used for basic setup and
  configuration. Here you can enable bubbles, add global middleware and
  register services in the container, etc.
*/

public protocol Kernel: class, ServiceMapper {

  /// Kernel configuration.
  static var scheme: KernelScheme { get }

  /// Application-specific middleware.
  var middleware: [Middleware] { get }

  /// Application bubbles.
  var bubbles: [Bubble.Type] { get }
}

extension Kernel {

  /// Default bubbles.
  var frameworkBubbles: [Bubble.Type] {
    return [
      StencilBubble.self
    ]
  }

  // Default middleware.
  var frameworkMiddleware: [Middleware] {
    return [
      QueryParametersMiddleware(),
      BodyParametersMiddleware(),
      MethodMiddleware(),
      ErrorMiddleware()
    ]
  }

  /// Application service mappers.
  var serviceMappers: [ServiceMapper] {
    return [
      BootServiceMapper()
    ]
  }

  /// Application-specific middleware.
  public var middleware: [Middleware] {
    return []
  }

  /**
   Registers services in the application container.

   - Parameter container: Application container.
  */
  public func addServices(to container: Container) {}
}
