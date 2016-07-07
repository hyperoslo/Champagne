/**
  Middleware for internal error handling.
*/
public class ErrorMiddleware: Middleware {

  /**
    Tries to execute a request and creates a corresponding error if it fails.

    - Parameter request: The request.
    - Parameter next: The next responser.

    - Returns: The response.
    - Throws: `ErrorType` when response fails.
  */
  public func respond(to request: Request, chainingTo next: Responder) throws -> Response {
    let response: Response

    do {
      response = try next.respond(to: request)
    } catch let error as StatusError {
      response = Response(status: error.status, body: error.message)
    } catch {
      let status = Status.internalServerError
      response = Response(status: status, body: status.error.message)
    }

    return response
  }
}
