import String

/**
  Middleware for body parameter parsing.
*/
public class BodyParametersMiddleware: Middleware {

  /**
    Parses and sets body parameters.

    - Parameter request: The request.
    - Parameter next: The next responser.

    - Throws: `ErrorType` when response fails.
    - Returns: The response.
  */
  public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    guard request.method != Method.get else {
      return try next.respond(to: request)
    }

    var request = request

    if let bodyString = request.bodyString {
      let parameters = QueryParameterParser(string: bodyString).parse()

      parameters.forEach { key, value in
        request.parameters[key] = value
      }
    }

    return try next.respond(to: request)
  }
}
