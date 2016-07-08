/**
  Extracts parameters from a query string.
*/
struct QueryParameterParser {

  /// Input query string.
  let string: String

  /**
    Creates a new instance of `QueryParameterParser`.

    - Parameter string: A query string.
  */
  init(string: String) {
    self.string = string
  }

  /**
    Parses query string and returns parameters dictionary.

    - Returns: Parameters dictionary.
  */
  func parse() -> [String: String] {
    var parameters = [String: String]()

    for item in string.split(separator: "&") {
      let parts = item.split(separator: "=", maxSplits: 1)

      guard let key = parts.first,
        value = parts.last,
        encodedKey = try? String(percentEncoded: key),
        encodedValue = try? String(percentEncoded: value)
        else { continue }

      parameters[encodedKey] = encodedValue
    }

    return parameters
  }
}
