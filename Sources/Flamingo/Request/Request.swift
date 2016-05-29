import S4

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

  public var cookies: [String: String] {
    get {
      return storage["fl-cookies"] as? [String: String] ?? [:]
    }
    set(cookies) {
      storage["fl-cookies"] = cookies
    }
  }
}

extension Message {
  public var bodyString: String? {
    var mutatingBody = body
    let buffer = try? mutatingBody.becomeBuffer()
    return buffer?.description
  }
}
