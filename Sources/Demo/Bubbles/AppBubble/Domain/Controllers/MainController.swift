import Champagne

class MainController: Controller, RouteMapper {

  func draw(map: RouteCollection) {
    map.root(respond: index)
    map.get("info", respond: info)
  }

  func index(request: Request) throws -> Response {
    return render(template: "index")
  }

  func info(request: Request) throws -> Response {
    return render(template: "info")
  }
}
