/**
  Response extensions.
*/
extension Response {

  /// Status code helper.
  public var statusCode: Int {
    return status.statusCode
  }

  /// Reason phrase helper.
  public var reasonPhrase: String {
    return status.reasonPhrase
  }

  /// HTTP status line
  public var statusLine: String {
    return "HTTP/1.1 " + statusCode.description + " " + reasonPhrase + "\n"
  }

  /**
    Creates a new response.

    - Parameter status: The status code.
    - Parameter contentType: The content type.
    - Parameter body: Body data.
  */
  init(status: Status, contentType: ContentType, body: DataConvertible) {
    let headers: Headers = [
      "Server": "Flamingo \(Application.version)",
      "Content-Type": "\(contentType.rawValue); charset=utf8"
    ]

    self.init(status: status, headers: headers, body: body.data)
  }

  /**
    Creates a new response.

    - Parameter status: The status code.
    - Parameter headers: Response headers.
    - Parameter body: Body data.
  */
  public init(status: Status, headers: Headers = [:], body: DataConvertible) {
    self.init(status: status, headers: headers, body: body.data)
  }
}

// MARK: - CustomStringConvertible

extension Response: CustomStringConvertible {

  /// String representation.
  public var description: String {
    return statusLine + headers.description
  }
}
