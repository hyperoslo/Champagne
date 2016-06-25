import Foundation
import HTTPServer

public var application = Application()

/**
  Flamingo application.
*/
public class Application {

  public static let version = "0.0.1"

  public let environment: Environment
  public var router: Router
  var running = false

  var middleware: [Middleware] = [
    ParametersMiddleware(),
    ErrorMiddleware()
  ]

  /**
    Creates a new instance of `Application`.

    - Parameter environment: Environment.
    - Parameter middleware: Route-specific middleware.
  */
  public init(environment: Environment = Environment("development"),
              middleware: [Middleware] = []) {
    self.environment = environment
    self.middleware.append(contentsOf: middleware)
    router = Router(middleware: middleware)
  }

  // MARK: - Server

  /**
    Starts HTTP server with the router as a responder.
    - Throws: ErrorType.
  */
  public func start() throws {
    print(Art.header)
    try Server(responder: router).start()
    running = true
  }
}
