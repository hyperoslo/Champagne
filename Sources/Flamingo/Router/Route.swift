/**
  Route extensions.
*/

public final class Route {

  public static let defaultFallback = BasicResponder { _ in
    Response(status: .methodNotAllowed)
  }

  public let path: String
  public var actions: [Method: Responder]
  public var fallback: Responder

  public init(path: String,
           actions: [Method: Responder] = [:],
          fallback: Responder = Route.defaultFallback) {
    self.path = path
    self.actions = actions
    self.fallback = fallback
  }

  public func addAction(method: Method, action: Responder) {
    actions[method] = action
  }
}

// MARK: - Responder

extension Route: Responder {

  public func respond(to request: Request) throws -> Response {
    let action = actions[request.method] ?? fallback
    return try action.respond(to: request)
  }
}
