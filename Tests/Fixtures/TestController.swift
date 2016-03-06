@testable import Flamingo

class TestResourceController: ResourceController {

  required init() {}

  func index(request: Request) throws -> Response {
    return Response(status: .Ok, data: [], contentType: .HTML)
  }

  func show(request: Request) throws -> Response {
    return Response(status: .Ok, data: [], contentType: .HTML)
  }

  func new(request: Request) throws -> Response {
    return Response(status: .Ok, data: [], contentType: .HTML)
  }

  func create(request: Request) throws -> Response {
    return Response(status: .Created, data: [], contentType: .HTML)
  }

  func edit(request: Request) throws -> Response {
    return Response(status: .Created, data: [], contentType: .HTML)
  }

  func update(request: Request) throws -> Response {
    return Response(status: .NoContent, data: [], contentType: .HTML)
  }

  func destroy(request: Request) throws -> Response {
    return Response(status: .NoContent, data: [], contentType: .HTML)
  }
}
