/**
  A `Bubble` is your bundle/component that helps to organize the project
  code and spit functionality into separate feature-based modules.

  Bubbles used in your application must be returned by the `bubbles` computed
  property of the `Kernel` implementation class.
*/
public protocol Bubble: class, ContainerAware, RouteMapper {

  /// Bubble configuration.
  static var scheme: BubbleScheme { get }

  /// Bubble-specific middleware.
  var middleware: [Middleware] { get }

  /**
    The place to register sevices in the application container.

    - Parameter kernel: Application kernel.
  */
  func mount(on kernel: Kernel)
}

public extension Bubble {

  /// Bubble-specific middleware.
  var middleware: [Middleware] {
    return []
  }

  /**
    The place to register sevices in the application container.

    - Parameter kernel: Application kernel.
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
