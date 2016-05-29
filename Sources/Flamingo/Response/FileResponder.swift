import Foundation
import PathKit

struct FileResponder: Responder {

  func respond(to request: Request) throws -> Response {
    guard let path = request.uri.path where path != "/" else {
      throw StatusError(Response.Status.notFound)
    }

    let publicPath = Path(Config.publicDirectory)

    guard publicPath.exists && publicPath.isDirectory else {
      throw StatusError(Response.Status.notFound)
    }

    let filePath = publicPath + String(path.characters.dropFirst())

    guard filePath.exists else {
      throw StatusError(Response.Status.notFound)
    }

    guard filePath.isReadable else {
      throw StatusError(Response.Status.forbidden)
    }

    let response: Response

    do {
      let data = try filePath.read()
      guard let body = String(data: data, encoding: NSUTF8StringEncoding) else {
        throw StatusError(Response.Status.notFound)
      }

      response = Response(status: .ok, body: body)
    } catch {
      throw StatusError(Response.Status.notFound)
    }

    return response
  }
}
