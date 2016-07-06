import Jay

// MARK: - Initializers

extension JSON {

  /**
    Creates a new instance of `JSON` from a `[String: Any]` dictionary.

    - Parameter dictionary: A dictionary.
    - Throws: An error that occurs during initialization from a dictionary.
  */
  public init(_ dictionary: [String: Any]) throws {
    let jay = Jay(formatting: .minified)
    let data = try jay.dataFromJson(anyDictionary: dictionary)

    try self.init(data: Data(data))
  }

  /**
    Creates a new instance of `JSON` from a boolean value.

    - Parameter value: Boolean value.
  */
  public init(_ value: Bool) {
    self = .boolean(value)
  }

  /**
    Creates a new instance of `JSON` from a double value.

    - Parameter value: Double value.
  */
  public init(_ value: Double) {
    self = .number(.double(value))
  }

  /**
    Creates a new instance of `JSON` from a string value.

    - Parameter value: String value.
  */
  public init(_ value: String) {
    self = .string(value)
  }

  /**
    Creates a new instance of `JSON` from a [String : JSON] dictionary.

    - Parameter value: A dictionary.
  */
  public init(_ value: [String : JSON]) {
    self = .object(value)
  }
}

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
