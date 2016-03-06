public struct Route {

  public typealias Action = (Request) throws -> Response

  let path: String
  let method: Request.Method
  let action: Action
}

// MARK: - Hashable

extension Route: Hashable {

  public var hashValue: Int {
    return "\(method.rawValue) \(path)".hashValue
  }
}

// MARK: - Equatable

public func ==(lhs: Route, rhs: Route) -> Bool {
  return lhs.path == rhs.path
    && lhs.method == rhs.method
}

