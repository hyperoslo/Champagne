import Foundation

public class Request {

  public enum Method:String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
    case HEAD = "HEAD"
    case OPTIONS = "OPTIONS"
  }

  public let path: String
  public let hostname: String
  public let method: Method
  public let body: [UInt8]
  public let headers: [String: String]
  public let cookies = [String: String]()

  public init(method: Method, path: String, headers: [String: String], body: [UInt8]) {
    self.method = method
    self.path = path.componentsSeparatedByString("?").first ?? ""
    self.body = body
    self.headers = headers
    self.hostname = headers["host"] ?? "*"
  }
}
