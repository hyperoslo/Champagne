import Foundation
import HTTPServer
import Router

#if os(Linux)
  import Glibc
#endif

public class Application {

  public static let version = "0.0.1"

  var router: Router?
  var running = false

  var middleware: [Middleware] = [
    ParametersMiddleware(),
    CookiesMiddleware(),
    ErrorMiddleware()
  ]

  public init() {}

  // MARK: - Routing

  public func draw(build: (map: RouteMap) -> Void) {
    guard !running else { return }
    router = Router("/", middleware: ParametersMiddleware(),
                    CookiesMiddleware(),
                    ErrorMiddleware()) { map in
                      map.fallback(responder: FileResponder())
                      build(map: map)
    }
  }

  // MARK: - Server

  public func start() throws {
    guard let router = router else {
      return
    }

    try Server(responder: router).start()
    running = true
  }
}
