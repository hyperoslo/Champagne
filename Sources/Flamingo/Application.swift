import Foundation
import S4
import HTTPServer

#if os(Linux)
  import Glibc
#endif

public class Application {

  public static let version = "0.0.1"

  var router = Router.create { route in }

  public init() {}

  public func route(build: (builder: RouterBuilder) -> Void) {
    router = Router.create(build: build)
  }

  public func start() throws {
    try Server(responder: router).start()
  }
}
