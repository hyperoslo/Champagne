/**
  The environment of the application
*/
public enum Environment: Equatable {
  case development
  case test
  case production
  case custom(String)

  init(_ name: String) {
    switch name.lowercased() {
    case "development":
      self = .development
    case "test":
      self = .test
    case "production":
      self = .production
    default:
      self = .custom(name)
    }
  }
}

// MARK: - CustomStringConvertible

extension Environment: CustomStringConvertible {

  public var description: String {
    let result: String

    switch self {
    case development:
      result = "development"
    case test:
      result = "test"
    case production:
      result = "production"
    case custom(let string):
      result = string
    }

    return result
  }
}

public func == (lhs: Environment, rhs: Environment) -> Bool {
  return lhs.description == rhs.description
}
