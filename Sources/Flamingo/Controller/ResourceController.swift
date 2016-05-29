public protocol ResourceController: ApplicationController {

  func index(request: Request) throws -> Response
  func show(request: Request) throws -> Response
  func new(request: Request) throws -> Response
  func create(request: Request) throws -> Response
  func edit(request: Request) throws -> Response
  func update(request: Request) throws -> Response
  func destroy(request: Request) throws -> Response
}
