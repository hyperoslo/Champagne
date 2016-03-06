public extension Response {

  public enum ContentType {
    case HTML
    case JSON
    case None
    case Other(String)


    var value: String? {
      let string: String?

      switch self {
      case .HTML:
        string = "text/html"
      case .JSON:
        string = "application/json"
      case .Other(let value):
        string = value
      default:
        string = nil
      }

      return string
    }
  }
}
