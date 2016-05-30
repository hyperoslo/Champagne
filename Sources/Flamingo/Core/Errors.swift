/**
  Response status error
*/
public struct StatusError: ErrorProtocol {
  let status: Status

  var message: String {
    return "\(status.statusCode) - \(status.reasonPhrase)"
  }

  init(_ status: Status) {
    self.status = status
  }
}

extension Status {
  var error: StatusError {
    return StatusError(self)
  }
}
