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
