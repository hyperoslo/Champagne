import TCP
import HTTPParser
import HTTPSerializer

/**
  Default S4-compatible HTTP web server
*/
public struct WebServer: Server {
  /// Server.
  public let server: C7.Host

  /// Responder.
  public let responder: S4.Responder

  /// Failure closure.
  public var failure: (ErrorProtocol) -> Void = { error in
    print("Error: \(error)")
  }

  /// Request parser.
  let parser: S4.RequestParser

  /// Response serializer.
  let serializer: S4.ResponseSerializer

  // Buffer size.
  let bufferSize: Int = 2048

  // MARK: - Initializers

  /**
    Creates a new `WebServer` instance.

    - Parameter host: HTTP Host.
    - Parameter port: TCP port.
    - Parameter responder: The responder.
  */
  public init(host: String, port: Int, responder: Responder) throws {
    self.server = try TCPServer(host: host, port: port, reusePort: false)
    self.parser = RequestParser()
    self.serializer = ResponseSerializer()
    self.responder = responder
  }

  // MARK: - Server

  /**
    Starts the server.
    - Throws: `ErrorType` when server fails.
  */
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

  /**
    Processes a given stream.

    - Parameter stream: Request stream.
    - Throws: `ErrorType` when processing fails.
  */
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

  /**
    Processes a given data.

    - Parameter stream: Request data.
    - Throws: `ErrorType` when processing fails.
  */
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
