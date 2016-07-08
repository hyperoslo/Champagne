import Foundation

/**
  Default fallback responder.
*/
struct FallbackResponder: Responder {

  /// Asset provider.
  let container: Container

  /**
    Creates a new instance of `FallbackResponder`.

    - Parameter container: Application container.
  */
  init(container: Container) {
    self.container = container
  }

  /**
    Responds with a chain of error middleware and file responder.

    - Parameter request: The request.

    - Returns: The response.
    - Throws: Response error.
  */
  func respond(to request: Request) throws -> Response {
    guard let assetProvider = container.resolve(AssetProvider.self) else {
      throw StatusError(Status.internalServerError)
    }

    return try ErrorMiddleware().respond(
      to: request,
      chainingTo: FileResponder(assetProvider: assetProvider)
    )
  }
}
