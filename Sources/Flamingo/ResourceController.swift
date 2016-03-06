import Inquiline

public protocol ResourceController {

  func index(request: Request) throws -> Response
  func new(request: Request) throws -> Response
  func create(request: Request) throws -> Response
  func edit(request: Request) throws -> Response
  func update(request: Request) throws -> Response
  func destroy(request: Request) throws -> Response
}

//
// public class ResourceController {
//
//   public init() {}
//
//   public typealias Action = (request: Request) -> Response
//
//   var actions = [String: Action]()
//
//
// }
