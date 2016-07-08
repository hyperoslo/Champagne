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
