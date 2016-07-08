/**
  Request extensions.
*/
extension Request {

  /// Request parameters.
  public var parameters: [String: String] {
    get {
      guard let parameters = storage["parameters"] as? [String: String] else {
        return [:]
      }

      return parameters
    }
    set(parameters) {
      storage["parameters"] = parameters
    }
  }

  /// Connection.
  var connection: String? {
    get {
      return headers.headers["connection"]
    }

    set(connection) {
      headers.headers["connection"] = connection
    }
  }

  /// HTTP persistent connection.
  var isKeepAlive: Bool {
    guard let connection = connection else {
      return false
    }

    return version.minor == 0
      ? connection.lowercased().index(of: "keep-alive") != nil
      : connection.lowercased().index(of: "close") != nil
  }
}
