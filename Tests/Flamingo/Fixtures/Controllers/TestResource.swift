@testable import Flamingo

class TestResource: ResourceResponseFactory {

  init() {}

  func index(request: Request) throws -> Response {
    return render(context: ["title": "Champagne"])
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
