import Foundation
import PathKit

/**
  Responder that serves static files from the public directory.
*/
struct FileResponder: Responder {

  /// Asset provider.
  let assetProvider: AssetProvider

  /**
    Creates a new instance of `AssetProvider`.

    - Parameter assetProvider: Asset provider.
  */
  init(assetProvider: AssetProvider) {
    self.assetProvider = assetProvider
  }

  /**
    Responds with a static file or an error.

    - Parameter request: The request.

    - Returns: The response.
    - Throws: `StatusError` when the file is not found or not readable.
  */
  func respond(to request: Request) throws -> Response {
    guard var path = request.uri.path where path != "/" else {
      throw StatusError(.notFound)
    }

    path = String(path.characters.dropFirst())

    guard let filePath = assetProvider.absolutePathFor(web: path)
      where filePath.exists && !filePath.isDirectory
      else { throw StatusError(.notFound) }

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
