extension Dictionary {

  /**
    Transforms dictionary values.

    - Parameter transform: Transfrom closure.
    - Returns: New dictionary with the same keys and transformed values.
  */
  func mapValues<T>(_ transform: (Value) -> T) -> [Key: T] {
    var dictionary = [Key: T]()

    forEach {
      dictionary[$0] = transform($1)
    }

    return dictionary
  }
}
