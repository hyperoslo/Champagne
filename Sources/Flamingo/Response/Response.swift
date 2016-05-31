/**
  Response extensions
*/
extension Response {

  /**
    Creates a new response
    - Parameter status: The status code
    - Parameter contentType: The content type
    - Parameter body: Body data
  */
  init(status: Status, contentType: ContentType, body: DataConvertible) {
    let headers: Headers = [
      "Server": Header("Flamingo \(Application.version)"),
      "Content-Type": Header("\(contentType.rawValue); charset=utf8")
    ]

    self.init(status: status, headers: headers, body: body.data)
  }
}
