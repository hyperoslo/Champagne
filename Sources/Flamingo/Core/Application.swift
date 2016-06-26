import Foundation

public var application = Application()

/**
  Flamingo application.
*/
public class Application {

  public static let version = "0.2.1"

  /// Application environment.
  public let environment: Environment

  /// Application router.
  public let router: Router

  /// S4-compatible server type.
  public let server: Server.Type

  /// Flag that indicates if server is running.
  var running = false

  // Application middleware.
  var middleware: [Middleware] = [
    ParametersMiddleware(),
    ErrorMiddleware()
  ]

  /**
    Creates a new instance of `Application`.

    - Parameter server: S4-compatible server type.
    - Parameter environment: Environment.
    - Parameter middleware: Route-specific middleware.
  */
  public init(server: Server.Type = WebServer.self,
         environment: Environment = Environment("development"),
          middleware: [Middleware] = []) {
    self.server = server
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

    try server.init(host: "0.0.0.0", port: 8080, responder: router).start()
    running = true
  }
}
