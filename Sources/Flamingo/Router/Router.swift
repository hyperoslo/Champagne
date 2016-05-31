@_exported import RegexRouteMatcher

/**
  Default HTTP router. Responds to requests and provides an interface
  for drawing and composing routes.
*/
public final class Router: HTTP.Router {
  public let path: String
  public var container: RouteContainer
  private let middleware: [Middleware]

  public var fallback: Responder = BasicResponder { request in
    try ErrorMiddleware().respond(to: request, chainingTo: FileResponder())
  }

  public var routes: [Route] {
    return container.routes
  }

  // MARK: - Initialization

  public init(path: String = "", middleware: [Middleware]) {
    self.path = path
    self.middleware = middleware
    self.container = RouteContainer(path: path)
  }

  public convenience init(path: String, middleware: Middleware...) {
    self.init(path: path, middleware: middleware)
  }

  // MARK: - Routing

  public func draw(build: (container: RouteContainer) -> Void) {
    container = RouteContainer(path: path)
    build(container: container)
  }

  public func compose(build: (container: RouteContainer) -> Void) {
    build(container: container)
  }

  public func match(_ request: Request) -> Route? {
    let matcher = RegexRouteMatcher(routes: routes)
    return matcher.match(request)
  }

  public func respond(to request: Request) throws -> Response {
    let responder = match(request) ?? fallback
    return try middleware.chain(to: responder).respond(to: request)
  }
}
