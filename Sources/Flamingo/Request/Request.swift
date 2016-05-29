extension Request {

  /// URL parameters
  public var parameters: [String: String] {
    get {
      return storage["fl-parameters"] as? [String: String] ?? [:]
    }
    set(parameters) {
      storage["fl-parameters"] = parameters
    }
  }

  /// Cookies
  public var cookies: [String: String] {
    get {
      return storage["fl-cookies"] as? [String: String] ?? [:]
    }
    set(cookies) {
      storage["fl-cookies"] = cookies
    }
  }
}

public extension Message {

  var bodyString: String? {
    var bufferBody = body
    return try? bufferBody.becomeBuffer().description
  }
}
