public extension Response {

  public enum ContentType {
    case HTML
    case JSON
    case None
    case Custom(String)

    var value: String {
      let string: String

      switch self {
      case .HTML:
        string = "text/html"
      case .JSON:
        string = "application/json"
      case .Custom(let value):
        string = value
      default:
        string = ""
      }

      return string
    }
  }
}

// MARK: - Hashable

extension Response.ContentType: Hashable {

  public var hashValue: Int {
    return value.hashValue
  }
}

// MARK: - Equatable

public func ==(lhs: Response.ContentType, rhs: Response.ContentType) -> Bool {
  return lhs.value == rhs.value
}
