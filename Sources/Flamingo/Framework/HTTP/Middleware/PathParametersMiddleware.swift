public struct PathParametersMiddleware: Middleware {
  let parameters: [String: String]

  public init(_ parameters: [String: String]) {
    self.parameters = parameters
  }

  public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    var request = request

    parameters.forEach {
      request.pathParameters[$0] = $1
    }

    return try next.respond(to: request)
  }
}
