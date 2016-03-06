import Foundation

public class Router: Routing {

  var routes = [Int: Route]()

  public init() {}

  public func resources(name: String, controller: ResourceController) {
    let name = "/" + name

    get(name, controller.index)
    get(name + "/new", controller.new)
    get(name + "/{id}", controller.show)
    get(name + "/{id}/edit", controller.edit)
    post(name, controller.create)
    delete(name + "/{id}", controller.destroy)
    patch(name + "/{id}", controller.update)
  }

  public func get(path: String, _ action: Route.Action) {
    add(Route(path: path, method: .GET, action: action))
  }

  public func post(path: String, _ action: Route.Action) {
    add(Route(path: path, method: .POST, action: action))
  }

  public func put(path: String, _ action: Route.Action) {
    add(Route(path: path, method: .PUT, action: action))
  }

  public func patch(path: String, _ action: Route.Action) {
    add(Route(path: path, method: .PATCH, action: action))
  }

  public func delete(path: String, _ action: Route.Action) {
    add(Route(path: path, method: .DELETE, action: action))
  }

  public func head(path: String, _ action: Route.Action) {
    add(Route(path: path, method: .HEAD, action: action))
  }

  public func options(path: String, _ action: Route.Action) {
    add(Route(path: path, method: .OPTIONS, action: action))
  }

  func add(route: Route) {
    routes[route.hashValue] = route
  }
}
