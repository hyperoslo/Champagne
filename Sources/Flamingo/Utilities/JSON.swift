import Jay

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

// MARK: - DataConvertible

extension JSON: DataConvertible {

  /**
    Creates a new instance of `JSON` from `Data`.

    - Parameter data: Data.
    - Throws: An error that occurs during initialization from data.
  */
  public init(data: Data) throws {
    self = try Jay().jsonFromData(data.bytes)
  }

  /// Data from JSON
  public var data: Data {
    let jay = Jay(formatting: .minified)

    guard let data = try? jay.dataFromJson(json: self) else {
      return Data()
    }

    return Data(data)
  }
}

extension JSON: JSONConvertible {
  /**
    Creates a new instance of `Self`.

    - Parameter json: JSON object.
    - Throws: An error that occurs during initialization.
  */
  public init(json: JSON) throws {
    self = json
  }

  /// JSON object
  public var json: JSON {
    return self
  }
}

// MARK: - Literal Convertibles

extension JSON: ArrayLiteralConvertible {

  /**
    Creates a new instance of `JSON` from `JSON` elements.

    - Parameter elements: `JSON` elements.
  */
  public init(arrayLiteral elements: JSON...) {
    self = .array(elements)
  }
}

extension JSON: DictionaryLiteralConvertible {

  /**
    Creates a new instance of `JSON` from `JSON` dictionary elements.

    - Parameter elements: `JSON` dictionary elements.
  */
  public init(dictionaryLiteral elements: (String, JSON)...) {
    var dictionary = [String : JSON](minimumCapacity: elements.count)

    elements.forEach { key, value in
      dictionary[key] = value
    }

    self = .object(dictionary)
  }
}

extension JSON: NilLiteralConvertible {

  /**
    Creates a new instance of `JSON` from nil literal.

    - Parameter value: Nil literal.
  */
  public init(nilLiteral value: Void) {
    self = .null
  }
}
