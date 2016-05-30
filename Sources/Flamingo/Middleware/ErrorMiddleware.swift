/**
  Middleware for internal error handling
*/
public class ErrorMiddleware: Middleware {

  /**
    Tries to execute a request and creates a corresponding error if it fails.
    - Parameter request: The request
    - Paramater chainingTo: The next responser
    - Returns: The response
  */
  public func respond(to request: Request, chainingTo chain: Responder) throws -> Response {
    let response: Response

    do {
      response = try chain.respond(to: request)
    } catch let error as StatusError {
      response = Response(status: error.status, body: error.message)
    } catch {
      let status = Status.internalServerError
      response = Response(status: status, body: status.error.message)
    }

    return response
  }
}
