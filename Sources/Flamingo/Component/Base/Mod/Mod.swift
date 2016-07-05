public protocol Mod: class, ContainerAware, RouteMapper {

  /// Mod configuration.
  var scheme: ModScheme { get }

  /// Mod-specific middleware.
  var middleware: [Middleware] { get }

  /**
    The place to register sevices in the application container.

    Parameter kernel: Application kernel.
  */
  func mount(on kernel: Kernel)
}

public extension Mod {

  var middleware: [Middleware] {
    return []
  }

  /**
    The place to register sevices in the application container.
  */
  func mount() {}

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
  func controller<T: Controller>(_ type: T.Type) -> Controller {
    return T.init(modScheme: scheme, container: container)
  }
}
