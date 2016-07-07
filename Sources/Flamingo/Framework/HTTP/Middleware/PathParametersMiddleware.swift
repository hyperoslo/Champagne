/**
  Middleware fto set path parameters.
*/
public struct PathParametersMiddleware: Middleware {
  /// Path parameters.
  let parameters: [String: String]

  /**
    Creates a new instance of `PathParametersMiddleware`

    - Parameter parameters: Path parameters.
  */
  public init(_ parameters: [String: String]) {
    self.parameters = parameters
  }

  /**
    Sets path parameters.

    - Parameter request: The request.
    - Parameter next: The next responser.

    - Returns: The response.
    - Throws: `ErrorType` when response fails.
  */
  public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    var request = request

    parameters.forEach {
      request.parameters[$0] = $1
    }

    return try next.respond(to: request)
  }
}
