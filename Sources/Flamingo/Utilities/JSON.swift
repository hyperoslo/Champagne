import Jay

public protocol JSONInitializable {
  init(json: JSON) throws
}

public protocol JSONRepresentable {
  var json: JSON { get }
}

public protocol JSONConvertible: JSONInitializable, JSONRepresentable {}

// MARK: - DataConvertible

extension JSON: DataConvertible {

  public init(data: Data) throws {
    self = try Jay().jsonFromData(data.bytes)
  }

  public var data: Data {
    let jay = Jay(formatting: .minified)

    guard let data = try? jay.dataFromJson(json: self) else {
      return Data()
    }

    return Data(data)
  }
}

// MARK: - Literal Convertibles

extension JSON: ArrayLiteralConvertible {

  public init(arrayLiteral elements: JSON...) {
    self = .array(elements)
  }
}

extension JSON: DictionaryLiteralConvertible {

  public init(dictionaryLiteral elements: (String, JSON)...) {
    var dictionary = [String : JSON](minimumCapacity: elements.count)

    elements.forEach { key, value in
      dictionary[key] = value
    }

    self = .object(dictionary)
  }
}

extension JSON: NilLiteralConvertible {

  public init(nilLiteral value: Void) {
    self = .null
  }
}
