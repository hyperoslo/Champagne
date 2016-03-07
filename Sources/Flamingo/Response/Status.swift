public extension Response {

  public enum Status : Int {
    case Continue = 100
    case SwitchingProtocols = 101
    case Processing = 102
    case Ok = 200
    case Created = 201
    case Accepted = 202
    case NonAuthoritiveInformation = 203
    case NoContent = 204
    case ResetContent = 205
    case PartialContent = 206
    case MultiStatus = 207
    case AlreadyReported = 208
    case IMUsed = 226
    case MultipleChoices = 300
    case MovedPermanently = 301
    case Found = 302
    case SeeOther = 303
    case NotModified = 304
    case UseProxy = 305
    case Reserved = 306
    case TemporaryRedirect = 307
    case PermanentRedirect = 308
    case BadRequest = 400
    case Unauthorized = 401
    case PaymentRequired = 402
    case Forbidden = 403
    case NotFound = 404
    case MethodNotAllowed = 405
    case NotAcceptable = 406
    case ProxyAuthenticationRequired = 407
    case RequestTimeout = 408
    case Conflict = 409
    case Gone = 410
    case LengthRequired = 411
    case PreconditionFailed = 412
    case RequestEntityTooLarge = 413
    case RequestURITooLong = 414
    case UnsupportedMediaType = 415
    case RequestedRangeNotSatisfiable = 416
    case ExpectationFailed = 417
    case MisdirectedRequest = 421
    case UnprocessableEntity = 422
    case Locked = 423
    case FailedDependency = 424
    case UpgradeRequired = 426
    case PreconditionRequired = 428
    case TooManyRequests = 429
    case RequestHeaderFieldsTooLarge = 431
    case InternalServerError = 500
    case NotImplemented = 501
    case BadGateway = 502
    case ServiceUnavailable = 503
    case GatewayTimeout = 504
    case HTTPVersionNotSupported = 505
    case VariantAlsoNegotiates = 506
    case InsufficientStorage = 507
    case LoopDetected = 508
    case NotExtended = 510
    case NetworkAuthenticationRequired = 511

    public var reason:String {
      let string: String

      switch self {
      case .Continue:
        string = "Continue"
      case .SwitchingProtocols:
        string = "Switching Protocols"
      case .Processing:
        string = "Processing"
      case .Ok:
        string = "OK"
      case .Created:
        string = "Created"
      case .Accepted:
        string = "Accepted"
      case .NonAuthoritiveInformation:
        string = "Non-Authoritative Information"
      case .NoContent:
        string = "No Content"
      case .ResetContent:
        string = "Reset Content"
      case .PartialContent:
        string = "Partial Content"
      case .MultiStatus:
        string = "Multi-Status"
      case .AlreadyReported:
        string = "Already Reported"
      case .IMUsed:
        string = "IM Used"
      case .MultipleChoices:
        string = "Multiple Choices"
      case .MovedPermanently:
        string = "Moved Permanently"
      case .Found:
        string = "Found"
      case .SeeOther:
        string = "See Other"
      case .NotModified:
        string = "Not Modified"
      case .UseProxy:
        string = "Use Proxy"
      case .Reserved:
        string = "Reserved"
      case .TemporaryRedirect:
        string = "Temporary Redirect"
      case .PermanentRedirect:
        string = "Permanent Redirect"
      case .BadRequest:
        string = "Bad Request"
      case .Unauthorized:
        string = "Unauthorized"
      case .PaymentRequired:
        string = "Payment Required"
      case .Forbidden:
        string = "Forbidden"
      case .NotFound:
        string = "Not Found"
      case .MethodNotAllowed:
        string = "Method Not Allowed"
      case .NotAcceptable:
        string = "Not Acceptable"
      case .ProxyAuthenticationRequired:
        string = "Proxy Authentication Required"
      case .RequestTimeout:
        string = "Request Timeout"
      case .Conflict:
        string = "Conflict"
      case .Gone:
        string = "Gone"
      case .LengthRequired:
        string = "Length Required"
      case .PreconditionFailed:
        string = "Precondition Failed"
      case .RequestEntityTooLarge:
        string = "Request Entity Too Large"
      case .RequestURITooLong:
        string = "Request-URI Too Long"
      case .UnsupportedMediaType:
        string = "Unsupported Media Type"
      case .RequestedRangeNotSatisfiable:
        string = "Requested range not satisfiable"
      case .ExpectationFailed:
        string = "Expectation Failed"
      case .MisdirectedRequest:
        string = "Misdirected Request"
      case .UnprocessableEntity:
        string = "Unprocessable Entity"
      case .Locked:
        string = "Locked"
      case .FailedDependency:
        string = "Failed Dependency"
      case .UpgradeRequired:
        string = "Upgrade Required"
      case .PreconditionRequired:
        string = "Precondition Required"
      case .TooManyRequests:
        string = "Too Many Requests"
      case .RequestHeaderFieldsTooLarge:
        string = "Request Header Fields Too Large"
      case .InternalServerError:
        string = "Internal Server Error"
      case .NotImplemented:
        string = "Not Implemented"
      case .BadGateway:
        string = "Bad Gateway"
      case .ServiceUnavailable:
        string = "Service Unavailable"
      case .GatewayTimeout:
        string = "Gateway Timeout"
      case .HTTPVersionNotSupported:
        string = "HTTP Version Not Supported"
      case .VariantAlsoNegotiates:
        string = "Variant Also Negotiates"
      case .InsufficientStorage:
        string = "Insufficient Storage"
      case .LoopDetected:
        string = "Loop Detected"
      case .NotExtended:
        string = "Not Extended"
      case .NetworkAuthenticationRequired:
        string = "Network Authentication Required"
      }

      return string
    }

    public var description:String {
      return "\(code) \(reason)"
    }

    public var code:Int {
      return rawValue
    }
  }
}
