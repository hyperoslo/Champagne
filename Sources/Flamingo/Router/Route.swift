/**
  Route extensions.
*/

public final class Route {

  /// Default route fallback
  public static let defaultFallback = BasicResponder { _ in
    Response(status: .methodNotAllowed)
  }

  /// Route path
  public let path: String

  /// Route actions
  public var actions: [Method: Responder]

  /// Route fallback
  public var fallback: Responder

  /**
    Creates a new `Route` instance.

    - Parameter path: Route path.
    - Parameter actions: A list of actions.
    - Parameter fallback: A fallback.
  */
  public init(path: String,
           actions: [Method: Responder] = [:],
          fallback: Responder = Route.defaultFallback) {
    self.path = path
    self.actions = actions
    self.fallback = fallback
  }

  /**
    Adds a new action for a given method.

    - Parameter method: The request method.
    - Parameter action: The action.
  */
  public func addAction(method: Method, action: Responder) {
    actions[method] = action
  }
}

// MARK: - Responder

extension Route: Responder {

  /**
    Responds to request.

    - Parameter request: The request.

    - Throws: `ErrorType` when response fails.
    - Returns: The response.
  */
  public func respond(to request: Request) throws -> Response {
    let action = actions[request.method] ?? fallback
    return try action.respond(to: request)
  }
}
