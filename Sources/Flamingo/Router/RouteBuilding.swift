@_exported import HTTP

/**
  Basic protocol for route building.
*/
public protocol RouteBuilding {
  /// Root path.
  var path: String { get }

  /// List of registerd routes.
  var routes: [Route] { get set }

  /// Append leading slash to the route path
  var appendLeadingSlash: Bool { get }

  /// Append trailing slash to the route path
  var appendTrailingSlash: Bool { get }

  /**
    Builds a route and adds responder as an action on the corresponding method.

    - Parameter method: The request method.
    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func add(method: Request.Method, path: String, middleware: [Middleware], responder: Responder)

  /**
    Adds a fallback on a given path.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func fallback(on path: String, middleware: [Middleware], responder: Responder)
}

// MARK: - Default implementations

extension RouteBuilding {

  /**
    Registers `GET /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func get(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .get, path: path, middleware: middleware, responder: responder)
  }

  /**
    Registers `POST /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func post(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .post, path: path, middleware: middleware, responder: responder)
  }

  /**
    Registers `PUT /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func put(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .put, path: path, middleware: middleware, responder: responder)
  }

  /**
    Registers `PATCH /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func patch(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .patch, path: path, middleware: middleware, responder: responder)
  }

  /**
    Registers `DELETE /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func delete(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .delete, path: path, middleware: middleware, responder: responder)
  }

  /**
    Registers `OPTIONS /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func options(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .options, path: path, middleware: middleware, responder: responder)
  }

  /**
    Returns a route for a given path.

    - Parameter relativePath: Relative route path.
    - Returns: The route.
  */
  func routeFor(relativePath: String) -> BasicRoute? {
    let path = absolutePathFor(relativePath)
    return routes.filter({ $0.path == path }).first as? BasicRoute
  }

  /**
    Returns a route for a given path.

    - Parameter absolutePath: Absolute route path.
    - Returns: The route.
  */
  func routeFor(absolutePath: String) -> BasicRoute? {
    return routes.filter({ $0.path == absolutePath }).first as? BasicRoute
  }

  /**
    Builds and returns a full path.

    - Parameter path: The path of a route.
    - Returns: The full path.
  */
  func absolutePathFor(_ path: String) -> String {
    let root = self.path
    let path = path.hasPrefix("/") ? String(path.characters.dropFirst()) : path
    let separator = root.hasSuffix("/") ? "" : "/"
    var result = root + separator + path

    if appendTrailingSlash && !result.hasSuffix("/") {
      result = result + "/"
    } else if !appendTrailingSlash && result.hasSuffix("/") {
      result = String(result.characters.dropLast())
    }

    if appendLeadingSlash && !result.hasPrefix("/") {
      result = "/" + result
    } else if !appendLeadingSlash && result.hasPrefix("/") {
      result = String(result.characters.dropFirst())
    }

    return result
  }
}
