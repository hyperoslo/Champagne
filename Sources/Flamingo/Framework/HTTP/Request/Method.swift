/// Method extensions.
public extension Method {

  /**
    Creates a new `Method` from the raw value string.
  */
  init?(rawValue: String) {
    switch rawValue.uppercased() {
    case "HEAD":
      self = .head
    case "PATCH":
      self = .patch
    case "PUT":
      self = .put
    case "DELETE":
      self = .delete
    case "OPTIONS":
      self = .options
    default:
      return nil
    }
  }
}
