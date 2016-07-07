import String

/**
  Middleware to set the proper method specified under POST parameters.
*/
public class MethodMiddleware: Middleware {

  /**
    Resolves a method if it's specified under POST
    request parameters with a "_method" key.

    - Parameter request: The request.
    - Parameter next: The next responser.

    - Throws: `ErrorType` when response fails.
    - Returns: The response.
  */
  public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    guard let value = request.parameters["_method"]
      where request.method == Method.post
      else { return try next.respond(to: request) }

    var request = request

    if let method = Method(rawValue: value) {
      request.method = method
    }

    return try next.respond(to: request)
  }
}
