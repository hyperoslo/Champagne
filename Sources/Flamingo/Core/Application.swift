import Foundation
import HTTPServer

#if os(Linux)
  import Glibc
#endif

/**
  Flamingo application
*/
public class Application {

  public static let version = "0.0.1"

  public var router: Router
  var running = false

  var middleware: [Middleware] = [
    ParametersMiddleware(),
    ErrorMiddleware()
  ]

  public init(middleware: [Middleware] = []) {
    self.middleware.append(contentsOf: middleware)
    router = Router(middleware: middleware)
  }

  // MARK: - Server

  public func start() throws {
    try Server(responder: router).start()
    running = true
  }
}
