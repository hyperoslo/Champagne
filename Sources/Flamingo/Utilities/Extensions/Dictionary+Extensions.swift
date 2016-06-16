extension Dictionary {

  func mapValues<T>(_ transform: (Value) -> T) -> [Key: T] {
    var dictionary = [Key: T]()

    self.forEach {
      dictionary[$0] = transform($1)
    }

    return dictionary
  }
}
