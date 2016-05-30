/**
  Middleware to manage cookies
*/
public class CookiesMiddleware: Middleware {

  /**
    Parses and sets cookie header from the request to the response.
    - Parameter request: The request
    - Paramater chainingTo: The next responser
    - Returns: The response
  */
  public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    var request = request

    if let cookieString = request.headers["Cookie"].values.first {
      let cookieItem = cookieString.split(separator: ";")

      cookieItem.forEach {
        let keyValue = $0.split(separator: "=")
        request.cookies[keyValue[0]] = keyValue[1]
      }
    }

    var response = try next.respond(to: request)
    let headerValue = response.cookies.map({ "\($0)=\($1)" }).joined(separator: ";")

    response.headers["Set-Cookie"] = Header(headerValue)

    return response
  }
}
