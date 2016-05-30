/**
  Response status error
*/
public struct StatusError: ErrorProtocol {

  public let status: Status

  public var message: String {
    return "\(status.statusCode) - \(status.reasonPhrase)"
  }

  public init(_ status: Status) {
    self.status = status
  }
}

/**
  Status extension to create an error.
*/
public extension Status {

  var error: StatusError {
    return StatusError(self)
  }
}
