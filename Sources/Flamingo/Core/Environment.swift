/**
  The environment of the application
*/
public struct Environment: Equatable {

  /// Environment value
  public let value: String

  /**
    Creates a new instance of `Environment`.

    - Parameter value: Environment string value.
  */
  public init(_ value: String) {
    self.value = value
  }

  /// Checks if the current environment is production
  public var isProduction: Bool {
    return value.lowercased() == "production"
  }

  /// Checks if the current environment is development
  public var isDevelopment: Bool {
    return value.lowercased() == "development"
  }

  /// Checks if the current environment is test
  public var isTest: Bool {
    return value.lowercased() == "test"
  }
}

// MARK: - CustomStringConvertible

extension Environment: CustomStringConvertible {

  /// String representation
  public var description: String {
    return value
  }
}

// MARK: - Equatable

public func == (lhs: Environment, rhs: Environment) -> Bool {
  return lhs.value == rhs.value
}
