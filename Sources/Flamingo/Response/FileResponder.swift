import Foundation
import PathKit

/**
  Responder that serves static files from the public directory.
*/
struct FileResponder: Responder {

  /**
    Responds with a static file or an error.

    - Parameter request: The request.

    - Throws: `StatusError` when the file is not found or not readable.
    - Returns: The response.
  */
  func respond(to request: Request) throws -> Response {
    guard let path = request.uri.path where path != "/" else {
      throw StatusError(.notFound)
    }

    let publicPath = Path(Config.publicDirectory)

    guard publicPath.exists && publicPath.isDirectory else {
      throw StatusError(.notFound)
    }

    let filePath = publicPath + String(path.characters.dropFirst())

    guard filePath.exists else {
      throw StatusError(.notFound)
    }

    guard filePath.isReadable else {
      throw StatusError(.forbidden)
    }

    let response: Response

    do {
      let data = try filePath.read()
      guard let body = String(data: data, encoding: NSUTF8StringEncoding) else {
        throw StatusError(.notFound)
      }

      response = Response(status: .ok, body: body)
    } catch {
      throw StatusError(.notFound)
    }

    return response
  }
}
