import Foundation
import PathKit

/**
  Responder that serves static files from the public directory
*/
struct FileResponder: Responder {

  /**
    Responds with a static file or an error.
    - Parameter request: The request
    - Returns: The response
  */
  func respond(to request: Request) throws -> Response {
    guard let path = request.uri.path where path != "/" else {
      throw StatusError(Status.notFound)
    }

    let publicPath = Path(Config.publicDirectory)

    guard publicPath.exists && publicPath.isDirectory else {
      throw StatusError(Status.notFound)
    }

    let filePath = publicPath + String(path.characters.dropFirst())

    guard filePath.exists else {
      throw StatusError(Status.notFound)
    }

    guard filePath.isReadable else {
      throw StatusError(Status.forbidden)
    }

    let response: Response

    do {
      let data = try filePath.read()
      guard let body = String(data: data, encoding: NSUTF8StringEncoding) else {
        throw StatusError(Status.notFound)
      }

      response = Response(status: .ok, body: body)
    } catch {
      throw StatusError(Status.notFound)
    }

    return response
  }
}
