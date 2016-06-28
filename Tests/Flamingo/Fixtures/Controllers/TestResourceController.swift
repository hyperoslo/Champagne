@testable import Flamingo

class TestResourceController: ResourceController {

  required init() {}

  func index(request: Request) throws -> Response {
    return render(context: ["title": "Flamingo"])
  }

  func show(request: Request) throws -> Response {
    return render(template: "index")
  }

  func new(request: Request) throws -> Response {
    return render(template: "index")
  }

  func create(request: Request) throws -> Response {
    return render(template: "index")
  }

  func edit(request: Request) throws -> Response {
    return render(template: "index")
  }

  func update(request: Request) throws -> Response {
    return render(template: "index")
  }

  func destroy(request: Request) throws -> Response {
    return render(template: "index")
  }
}
