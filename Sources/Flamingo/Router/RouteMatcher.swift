import Rexy

public struct RouteMatcher {
  let mathers: [RouteRegex]

  public init(routes: [Route]) {
    self.mathers = routes.map(RouteRegex.init)
  }

  public func match(_ request: Request) -> Route? {
    guard let regex = mathers.filter({ $0.matches(request) }).first else {
      return nil
    }

    let parameters = regex.parameters(request)
    let middleware = PathParameterMiddleware(parameters)

    return BasicRoute(
      path: regex.route.path,
      actions: regex.route.actions.mapValues({ middleware.chain(to: $0) }),
      fallback: regex.route.fallback
    )
  }
}

struct RouteRegex {
  let regex: Regex
  let parameterKeys: [String]
  let route: Route

  init(route: Route) {
    let parameterRegex = try! Regex(pattern: ":([[:alnum:]]+)")
    let pattern = parameterRegex.replace(route.path, with: "([[:alnum:]_-]+)")

    self.regex = try! Regex(pattern: "^" + pattern + "$")
    self.parameterKeys = parameterRegex.groups(route.path)
    self.route = route
  }

  func matches(_ request: Request) -> Bool {
    guard let path = request.path else {
      return false
    }

    return regex.matches(path)
  }

  func parameters(_ request: Request) -> [String: String] {
    guard let path = request.path else {
      return [:]
    }

    var parameters = [String: String]()
    let values = regex.groups(path)

    for (index, key) in parameterKeys.enumerated() {
      parameters[key] = values[index]
    }

    return parameters
  }
}
