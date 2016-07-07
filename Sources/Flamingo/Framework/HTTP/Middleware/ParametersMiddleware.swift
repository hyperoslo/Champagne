import String

/**
  Middleware for parameter parsing.
*/
public class ParametersMiddleware: Middleware {

  /**
    Parses and sets request parameters.

    - Parameter request: The request.
    - Parameter next: The next responser.

    - Throws: `ErrorType` when response fails.
    - Returns: The response.
  */
  public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    var request = request
    var queryString = ""

    if request.method == Method.get {
      if let elements = request.uri.path?.split(separator: "?", maxSplits: 1), query = elements.last {
        queryString = query
      }
    } else if let body = request.bodyString {
      queryString = body
    }

    for parameter in queryString.split(separator: "&") {
      let tokens = parameter.split(separator: "=", maxSplits: 1)

      guard let name = tokens.first,
        value = tokens.last,
        parsedName = try? String(percentEncoded: name),
        parsedValue = try? String(percentEncoded: value)
        else { continue }

      request.parameters[parsedName] = parsedValue
    }

    request.method = resolveMethod(request: request)

    return try next.respond(to: request)
  }

  /**
    Resolves a method if it's specified under POST
    request parameters with a "_method" key.

    - Parameter request: The request.
    - Returns: The method.
  */
  func resolveMethod(request: Request) -> Method {
    guard request.method == Method.post else {
      return request.method
    }

    guard let methodParameter = request.parameters["_method"] else {
      return request.method
    }

    var resolvedMethod: Method

    if let method = Method(rawValue: methodParameter) {
      resolvedMethod = method
    } else {
      resolvedMethod = request.method
    }

    return resolvedMethod
  }
}
