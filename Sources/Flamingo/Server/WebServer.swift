import TCP
import HTTPParser
import HTTPSerializer

public struct WebServer: Server {
  public let server: C7.Host
  public let port: Int
  public let responder: S4.Responder

  public var failure: (ErrorProtocol) -> Void = { error in
    print("Error: \(error)")
  }

  let parser: S4.RequestParser
  let serializer: S4.ResponseSerializer
  let bufferSize: Int = 2048

  // MARK: - Initializers

  public init(host: String, port: Int, responder: Responder) throws {
    self.server = try TCPServer(host: host, port: port, reusePort: false)
    self.port = port
    self.parser = RequestParser()
    self.serializer = ResponseSerializer()
    self.responder = responder
  }

  // MARK: - Server

  public func start() throws {
    while true {
      let stream = try server.accept(timingOut: .never)

      co {
        do {
          try self.processStream(stream)
        } catch {
          self.failure(error)
        }
      }
    }
  }

  // MARK: - Processing

  private func processStream(_ stream: Stream) throws {
    while !stream.closed {
      do {
        let data = try stream.receive(upTo: bufferSize)
        try processData(data, stream: stream)
      } catch is SystemError {
        break
      } catch is StreamError {
        break
      } catch {
        let response = Response(status: .internalServerError)
        try serializer.serialize(response, to: stream)
        throw error
      }
    }
  }

  private func processData(_ data: Data, stream: Stream) throws {
    guard let request = try parser.parse(data) else {
      return
    }

    let response = try responder.respond(to: request)
    try serializer.serialize(response, to: stream)

    if let upgrade = response.didUpgrade {
      try upgrade(request, stream)
      try stream.close()
    }

    if !request.isKeepAlive {
      try stream.close()
    }
  }
}

// S4.Server extension

extension Server {

  public init(host: String, port: Int, _ respond: Respond) throws {
    let responder = BasicResponder(respond)
    try self.init(host: host, port: port, responder: responder)
  }
}
