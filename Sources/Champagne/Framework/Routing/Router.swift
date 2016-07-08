import Rexy

/**
  Default HTTP router. Responds to requests and provides an interface
  for drawing and composing routes.
*/
public final class Router {

  /// Route collection
  public var collection: RouteCollection

  /// Router middleware.
  public let middleware: [Middleware]

  /// Router default fallback
  public var fallback: Responder

  /// List of routes
  public var routes: [Route] {
    return collection.routes
  }

  /**
    Creates a new `Router` instance.

    - Parameter collection: Route collection.
    - Parameter fallback: Router fallback.
    - Parameter middleware: Router middleware.
  */
  public init(collection: RouteCollection,
                fallback: Responder,
              middleware: [Middleware] = []) {
    self.collection = collection
    self.middleware = middleware
    self.fallback = fallback
  }

  // MARK: - Routing

  /**
    Builds and register new routes.

    - Parameter build: Building closure.
  */
  public func draw(build: (collection: RouteCollection) -> Void) {
    build(collection: collection)
  }

  /**
    Matches request to the route.

    - Parameter request: The request.
    - Returns: The route or nil if not found.
  */
  public func match(_ request: Request) -> Route? {
    guard let path = request.uri.path,
      result = routes
        .map({ (route: $0, matcher: RouteMatcher($0.path)) })
        .filter({ $0.matcher.matches(path) }).first
      else { return nil }

    let route = result.route
    let middleware = PathParametersMiddleware(result.matcher.parameters(path))
    let actions = route.actions.mapValues({ middleware.chain(to: $0) })

    return Route(path: route.path, actions: actions, fallback: route.fallback)
  }
}

// MARK: - Responder

extension Router: Responder {

  /**
    Responds to given request.

    - Parameter request: The request.

    - Throws: `ErrorType` when response fails.
    - Returns: The response.
  */
  public func respond(to request: Request) throws -> Response {
    let responder = match(request) ?? fallback
    return try middleware.chain(to: responder).respond(to: request)
  }
}
