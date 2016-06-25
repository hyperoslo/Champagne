import S4
import TCP
import HTTPParser
import HTTPSerializer

public struct WebServer: Server {
  public let server: C7.Host
  public let port: Int
  public let responder: S4.Responder
  public let middleware: [S4.Middleware]

  let parser: S4.RequestParser
  let serializer: S4.ResponseSerializer
  let bufferSize: Int = 2048

  // MARK: - Initializers

  public init(host: String = "0.0.0.0", port: Int = 8080, middleware: [Middleware] = [], responder: Responder) throws {
    self.server = try TCPServer(host: host, port: port, reusePort: false)
    self.port = port
    self.parser = RequestParser()
    self.serializer = ResponseSerializer()
    self.middleware = middleware
    self.responder = responder
  }

  public init(host: String = "0.0.0.0", port: Int = 8080, middleware: [Middleware] = [], _ respond: Respond) throws {
    try self.init(
      host: host,
      port: port,
      middleware: middleware,
      responder: BasicResponder(respond)
    )
  }

  public init(host: String, port: Int, responder: Responder) throws {
    try self.init(host: host, port: port, middleware: [], responder: responder)
  }

  public func start() throws {

  }
}
