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
  func add(method: Method, path: String, middleware: [Middleware], responder: Responder)

  /**
    Adds a fallback on a given path.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func fallback(on path: String, middleware: [Middleware], responder: Responder)

  /**
    Removes all routes
  */
  func clear()
}

// MARK: - Default implementations

extension RouteBuilding {

  /**
    Returns a route for a given path.

    - Parameter relativePath: Relative route path.
    - Returns: The route.
  */
  func routeFor(relativePath: String) -> Route? {
    let path = absolutePathFor(relativePath)
    return routes.filter({ $0.path == path }).first
  }

  /**
    Returns a route for a given path.

    - Parameter absolutePath: Absolute route path.
    - Returns: The route.
  */
  func routeFor(absolutePath: String) -> Route? {
    return routes.filter({ $0.path == absolutePath }).first
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
