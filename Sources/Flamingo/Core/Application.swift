import Foundation
import HTTPServer

#if os(Linux)
  import Glibc
#endif

public var application = Application()

/**
  Flamingo application.
*/
public class Application {

  public static let version = "0.0.1"

  public var router: Router
  var running = false

  var middleware: [Middleware] = [
    ParametersMiddleware(),
    ErrorMiddleware()
  ]

  /**
    Creates a new instance of `Application`.

    - Parameter middleware: Route-specific middleware.
  */
  public init(middleware: [Middleware] = []) {
    self.middleware.append(contentsOf: middleware)
    router = Router(middleware: middleware)
  }

  // MARK: - Server

  /**
    Starts HTTP server with the router as a responder.
  */
  public func start() throws {
    print(Art.header)
    try Server(responder: router).start()
    running = true
  }
}
