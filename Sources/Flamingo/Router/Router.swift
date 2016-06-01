@_exported import RegexRouteMatcher

/**
  Default HTTP router. Responds to requests and provides an interface
  for drawing and composing routes.
*/
public final class Router: HTTP.Router {

  /// Root path
  public let path: String

  /// Route container
  public var container: RouteContainer

  /// Common middleware
  let middleware: [Middleware]

  /// Router default fallback
  public var fallback: Responder = BasicResponder { request in
    try ErrorMiddleware().respond(to: request, chainingTo: FileResponder())
  }

  /// List of routes
  public var routes: [Route] {
    return container.routes
  }

  /**
    Creates a new `Router` instance.

    - Parameter path: The root path.
    - Parameter middleware: Router-specific common middleware.
  */
  public init(path: String = "", middleware: [Middleware]) {
    self.path = path
    self.middleware = middleware
    self.container = RouteContainer(path: path)
  }

  /**
    Creates a new `Router` instance.

    - Parameter path: The root path.
    - Parameter middleware: Router-specific common middleware.
  */
  public convenience init(path: String, middleware: Middleware...) {
    self.init(path: path, middleware: middleware)
  }

  // MARK: - Routing

  /**
    Builds and register new routes. Creates a new container,
    so all existing routes will be removed.

    - Parameter build: Building closure.
  */
  public func draw(build: (container: RouteContainer) -> Void) {
    container = RouteContainer(path: path)
    build(container: container)
  }

  /**
    Builds and register new routes. Uses the same container,
    so all existing routes will not be removed.

    - Parameter build: Building closure.
  */
  public func compose(build: (container: RouteContainer) -> Void) {
    build(container: container)
  }

  /**
    Matches request with the route.

    - Parameter request: The request.
    - Returns: The route or nil if can't find.
  */
  public func match(_ request: Request) -> Route? {
    let matcher = RegexRouteMatcher(routes: routes)
    return matcher.match(request)
  }

  /**
    Responds to given request.

    - Parameter request: The request.
    - Returns: The response.
  */
  public func respond(to request: Request) throws -> Response {
    let responder = match(request) ?? fallback
    return try middleware.chain(to: responder).respond(to: request)
  }
}
