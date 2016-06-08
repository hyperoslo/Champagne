@testable import Flamingo

class TestResourceController: ResourceController {

  required init() {}

  func index(request: Request) throws -> Response {
    return render("index")
  }

  func show(request: Request) throws -> Response {
    return render("index")
  }

  func new(request: Request) throws -> Response {
    return render("index")
  }

  func create(request: Request) throws -> Response {
    return render("index")
  }

  func edit(request: Request) throws -> Response {
    return render("index")
  }

  func update(request: Request) throws -> Response {
    return render("index")
  }

  func destroy(request: Request) throws -> Response {
    return render("index")
  }
}

class TestRoutingController: RoutingController {

  required init() {}

  func draw(map: RouteContainer) {
    map.root(respond: index)
    map.get("info", respond: info)
  }

  func index(request: Request) throws -> Response {
    return render("index")
  }

  func info(request: Request) throws -> Response {
    return render("index")
  }
}
