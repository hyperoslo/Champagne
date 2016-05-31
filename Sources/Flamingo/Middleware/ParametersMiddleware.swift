import String

/**
  Middleware for parameter parsing.
*/
public class ParametersMiddleware: Middleware {

  /**
    Parses and sets request parameters.

    - Parameter request: The request.
    - Paramater chainingTo: The next responser.
    - Returns: The response.
  */
  public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    var request = request
    var queryString = ""

    if request.method == Request.Method.get {
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
  func resolveMethod(request: Request) -> Request.Method {
    guard request.method == Request.Method.post else {
      return request.method
    }

    guard let methodParameter = request.parameters["_method"] else {
      return request.method
    }

    let method: Request.Method

    switch methodParameter.uppercased() {
    case "HEAD":
      method = .head
    case "PATCH":
      method = .patch
    case "PUT":
      method = .put
    case "DELETE":
      method = .delete
    case "OPTIONS":
      method = .options
    default:
      method = request.method
    }

    return method
  }
}
