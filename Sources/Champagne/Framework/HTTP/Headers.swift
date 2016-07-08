/**
  Headers extensions.
*/
extension Headers: CustomStringConvertible {

  /// String representation
  public var description: String {
    var string = ""

    headers.forEach {
      string += "\($0): \($1)\n"
    }

    return string
  }
}
