import Rexy

/**
  Default route matcher. Matches request path to the route.
*/
struct RouteMatcher {

  /// Route regex
  var regex: Regex?

  /// Parameter keys
  let segments: [String]

  /**
    Creates a new `RouteMatcher` instance.

    - Parameter routePath: The route path.
  */
  init(_ routePath: String) {
    do {
      let parameterRegex = try Regex(pattern: ":([[:alnum:]]+)")
      let pattern = parameterRegex.replace(routePath, with: "([[:alnum:]_-]+)")

      regex = try Regex(pattern: "^" + pattern + "$")
      segments = parameterRegex.groups(routePath)
    } catch {
      segments = []
    }
  }

  /**
    Matches given path to the route.

    - Parameter path: The request path.
    - Returns: True or false if not found.
  */
  func matches(_ path: String) -> Bool {
    return regex?.matches(path) ?? false
  }

  /**
    Extracts parameters from a given request path.

    - Parameter path: The request path.
    - Returns: Parameters dictionary.
  */
  func parameters(_ path: String) -> [String: String] {
    var parameters = [String: String]()
    let values = regex?.groups(path) ?? []

    for (index, key) in segments.enumerated() {
      parameters[key] = values[index]
    }

    return parameters
  }
}
