extension Response {

  public var cookies: [String: String] {
    get {
      return storage["fl-cookies"] as? [String: String] ?? [:]
    }
    set(cookies) {
      storage["fl-cookies"] = cookies
    }
  }

  init(status: Status, contentType: ContentType, body: DataConvertible) {
    let headers: Headers = [
      "Server": Header("Flamingo \(Application.version)"),
      "Content-Type": Header("\(contentType.rawValue); charset=utf8")
    ]

    self.init(status: status, headers: headers, body: body.data)
  }
}
