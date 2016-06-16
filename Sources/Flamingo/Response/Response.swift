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

  public init(status: Status = .ok, headers: Headers = [:], body: Stream) {
    self.init(status: status, headers: headers, body: body)
  }

  public init(status: Status = .ok, headers: Headers = [:], body: Data = Data()) {
    self.init(status: status, headers: headers, body: body)
  }
}

extension Response {
  public var statusCode: Int {
    return status.statusCode
  }

  public var reasonPhrase: String {
    return status.reasonPhrase
  }

  public var cookies: Set<AttributedCookie> {
    get {
      return headers["Set-Cookie"].reduce(Set<AttributedCookie>()) { cookies, header in
        AttributedCookie.parse(header).map({ cookies.union([$0]) }) ?? cookies
      }
    }

    set(cookies) {
      headers["Set-Cookie"] = Header(cookies.map({ $0.description }))
    }
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

// MARK: - CustomDebugStringConvertible

extension Response: CustomDebugStringConvertible {
  public var debugDescription: String {
    return description + "\n\n" + storageDescription
  }
}
