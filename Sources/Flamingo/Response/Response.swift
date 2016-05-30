/**
  Response extensions
*/
extension Response {

  /// Cookies
  public var cookies: [String: String] {
    get {
      return storage["fl-cookies"] as? [String: String] ?? [:]
    }
    set(cookies) {
      storage["fl-cookies"] = cookies
    }
  }

  /**
    Creates a new response
    - Parameter status: The status code
    - Parameter contentType: The content type
    - Parameter body: Body data
  */
  init(status: Status, contentType: ContentType, body: DataConvertible) {
    let headers: Headers = [
      "Server": Header("Flamingo \(Application.version)"),
      "Content-Type": Header("\(contentType.rawValue); charset=utf8")
    ]

    self.init(status: status, headers: headers, body: body.data)
  }
}
