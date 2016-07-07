/**
  A basic protocol for types that could be inititalized with JSON.
*/
public protocol JSONInitializable {

  /**
    Creates a new instance of `Self`.

    - Parameter json: JSON object.
    - Throws: An error that occurs during initialization.
  */
  init(json: JSON) throws
}

/**
  A basic protocol for types that could be represented as a JSON.
*/
public protocol JSONRepresentable {

  /// JSON object
  var json: JSON { get }
}

/**
  A basic protocol for types that could be inititalized with JSON
  and represented as a JSON.
*/
public protocol JSONConvertible: JSONInitializable, JSONRepresentable {}
