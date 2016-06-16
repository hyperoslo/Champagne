/**
  Request extensions.
*/
extension Request {

  /// URL path.
  public var path: String? {
        return uri.path
    }

  /// URL query.
  public var query: [String: [String?]] {
    return uri.query
  }

  /// URL parameters.
  public var parameters: [String: String] {
    get {
      return storage["fl-parameters"] as? [String: String] ?? [:]
    }
    set(parameters) {
      storage["fl-parameters"] = parameters
    }
  }

  /// Path parameters.
  public var pathParameters: [String: String] {
    get {
      return storage["pathParameters"] as? [String: String] ?? [:]
    }

    set(pathParameters) {
      storage["pathParameters"] = pathParameters
    }
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
