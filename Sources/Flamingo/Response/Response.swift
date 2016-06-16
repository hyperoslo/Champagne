/**
  Response extensions.
*/
extension Response {

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

  public init(status: Status, headers: Headers = [:], body: DataConvertible) {
    self.init(status: status, headers: headers, body: body.data)
  }
}

extension Response {

  public var statusCode: Int {
    return status.statusCode
  }

  public var reasonPhrase: String {
    return status.reasonPhrase
  }
}

// MARK: - CustomStringConvertible

extension Response: CustomStringConvertible {

  public var statusLine: String {
    return "HTTP/1.1 " + statusCode.description + " " + reasonPhrase + "\n"
  }

  public var description: String {
    return statusLine + headers.description
  }
}
