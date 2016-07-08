import Champagne

struct Bird {
  let id: String
  let name: String
  let family: String

  var dictionary: [String: Any] {
    return [
      "id": id,
      "name": name,
      "family": family
    ]
  }
}

extension Bird: JSONRepresentable {

  var json: JSON {
    guard let json = try? JSON(dictionary) else {
      return JSON.null
    }

    return json
  }
}
