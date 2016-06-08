import Flamingo

class MainController: RoutingController {

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
