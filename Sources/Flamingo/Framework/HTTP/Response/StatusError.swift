/**
  Response status error.
*/
public struct StatusError: ErrorProtocol {

  /// Response status.
  public let status: Status

  /// Error message.
  public var message: String {
    return "\(status.statusCode) - \(status.reasonPhrase)"
  }

  /**
    Creates a new instance of `StatusError`.

    - Parameter status: Response status.
  */
  public init(_ status: Status) {
    self.status = status
  }
}

/**
  Status extension to create an error.
*/
public extension Status {

  /// Corresponding status error.
  var error: StatusError {
    return StatusError(self)
  }
}
