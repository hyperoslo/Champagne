import S4

public protocol ResourceController: ApplicationController {

  func index(request: Request) throws -> Response
  func show(request: Request) throws -> Response
  func new(request: Request) throws -> Response
  func create(request: Request) throws -> Response
  func edit(request: Request) throws -> Response
  func update(request: Request) throws -> Response
  func destroy(request: Request) throws -> Response
}

public extension ResourceController {
  public func render(_ template: String) -> Response {
    let body = Config.ViewRenderer.init(path: template, context: nil).render()
    return Response(status: .ok, contentType: .html, body: body)
  }
}
