public protocol Bubble: class, ContainerAware, RouteMapper {

  /// Bubble configuration.
  static var scheme: BubbleScheme { get }

  /// Bubble-specific middleware.
  var middleware: [Middleware] { get }

  /**
    The place to register sevices in the application container.

    Parameter kernel: Application kernel.
  */
  func mount(on kernel: Kernel)
}

public extension Bubble {

  var middleware: [Middleware] {
    return []
  }

  /**
    The place to register sevices in the application container.
  */
  func mount(on kernel: Kernel) {}

  /**
    Registers new routes.

    - Parameter map: Router.
  */
  func draw(map: RouteCollection) {}

  /**
    Creates a new instance of `Controller`.

    - Parameter type: Controller type.
    - Returns: A new controller of the given type.
  */
  func controller<T: Controller>(_ type: T.Type) -> T {
    return T.init(bubbleScheme: self.dynamicType.scheme, container: container)
  }
}
