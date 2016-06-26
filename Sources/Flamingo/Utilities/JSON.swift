import Jay

public protocol JSONInitializable {
  init(json: JSON) throws
}

public protocol JSONRepresentable {
  var json: JSON { get }
}

public protocol JSONConvertible: JSONInitializable, JSONRepresentable {}

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
