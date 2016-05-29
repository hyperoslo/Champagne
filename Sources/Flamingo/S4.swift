import S4
import C7
import Router

// MARK: - Basic

public typealias Byte = C7.Byte
public typealias Data = C7.Data
public typealias Stream = C7.Stream
public typealias URI = S4.URI
public typealias DataConvertible = S4.DataConvertible

// MARK: - Request

public typealias Request = S4.Request

extension Request {
  public typealias Method = S4.Method
  public typealias Body = S4.Body
  public typealias Headers = S4.Headers
}

// MARK: - Response

public typealias Response = S4.Response
public typealias Responder = S4.Responder
public typealias BasicResponder = S4.BasicResponder

extension Response {
  public typealias Status = S4.Status
  public typealias Body = S4.Body
  public typealias Headers = S4.Headers
}

// MARK: - Headers

extension S4.Headers {
  public typealias Values = S4.Header
  public typealias Key = C7.CaseInsensitiveString
}

// MARK: - Middleware

public typealias Middleware = S4.Middleware

// MARK: - Router

public typealias RouteMap = RouterBuilder
