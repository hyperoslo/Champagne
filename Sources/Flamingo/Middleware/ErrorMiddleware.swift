public struct StatusError: ErrorProtocol {
  let status: Response.Status

  var message: String {
    return "\(status.statusCode) - \(status.reasonPhrase)"
  }

  init(_ status: Response.Status) {
    self.status = status
  }
}

extension Response.Status {
  var error: StatusError {
    return StatusError(self)
  }
}

public class ErrorMiddleware: Middleware {

  public func respond(to request: Request, chainingTo chain: Responder) throws -> Response {
    let response: Response

    do {
      response = try chain.respond(to: request)
    } catch let error as StatusError {
      response = Response(status: error.status, body: error.message)
    } catch {
      let status = Response.Status.internalServerError
      response = Response(status: status, body: status.error.message)
    }

    return response
  }
}
