import String

/**
  Middleware for query parameter parsing.
*/
public class QueryParametersMiddleware: Middleware {

  /**
    Parses and sets query parameters.

    - Parameter request: The request.
    - Parameter next: The next responser.

    - Throws: `ErrorType` when response fails.
    - Returns: The response.
  */
  public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    guard request.method == Method.get else {
      return try next.respond(to: request)
    }

    var request = request
    let query = request.uri.path?.split(separator: "?", maxSplits: 1)

    if let queryString = query?.last {
      let parameters = QueryParameterParser(string: queryString).parse()

      parameters.forEach { key, value in
        request.parameters[key] = value
      }
    }

    return try next.respond(to: request)
  }
}
