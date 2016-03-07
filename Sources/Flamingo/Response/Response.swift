import Foundation

public class Response {

  public var status: Status
  public var data: [UInt8]
  public var contentType: ContentType
  public var headers: [String : String] = [:]
  public var cookies: [String : String] = [:]

  public init(status: Status, data: [UInt8], contentType: ContentType) {
    self.status = status
    self.data = [UInt8](data)
    self.contentType = contentType

    if !contentType.value.isEmpty {
      headers["Content-Type"] = contentType.value
    }

    headers["Server"] = "Flamingo \(Application.version)"
  }
}