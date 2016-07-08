/// Method extensions.
public extension Method {

  /**
    Creates a new `Method` from the raw value string.

    - Parameter rawValue: String raw value.
  */
  init?(rawValue: String) {
    switch rawValue.uppercased() {
    case "PATCH":
      self = .patch
    case "PUT":
      self = .put
    case "DELETE":
      self = .delete
    case "HEAD":
      self = .head
    case "OPTIONS":
      self = .options
    default:
      return nil
    }
  }
}
