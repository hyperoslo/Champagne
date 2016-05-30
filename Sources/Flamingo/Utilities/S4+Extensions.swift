import S4
import C7

/**
  Convenience typealiases for S4 types
*/

// MARK: - Basic

public typealias Byte = C7.Byte
public typealias Data = C7.Data
public typealias Stream = C7.Stream
public typealias URI = S4.URI
public typealias DataConvertible = S4.DataConvertible
public typealias Message = S4.Message
public typealias Body = S4.Body
public typealias Headers = S4.Headers
public typealias Header = S4.Header
public typealias Status = S4.Status

// MARK: - Request

public typealias Request = S4.Request

extension Request {
  public typealias Method = S4.Method
}

// MARK: - Response

public typealias Response = S4.Response
public typealias Responder = S4.Responder
public typealias BasicResponder = S4.BasicResponder

// MARK: - Headers

extension S4.Headers {
  public typealias Values = S4.Header
  public typealias Key = C7.CaseInsensitiveString
}

// MARK: - Middleware

public typealias Middleware = S4.Middleware
