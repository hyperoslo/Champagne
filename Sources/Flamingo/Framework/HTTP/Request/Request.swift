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

/**
  Message extensions.
*/
public extension Message {

  /// Converts body data to string.
  var bodyString: String? {
    var bufferBody = body
    return try? bufferBody.becomeBuffer().description
  }
}

extension Headers: CustomStringConvertible {

  /// String representation
  public var description: String {
    var string = ""

    headers.forEach {
      string += "\($0): \($1)\n"
    }

    return string
  }
}
