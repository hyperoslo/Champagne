@_exported import Router

public extension RouteMap {

  func root(middleware: Middleware..., responder: Responder) {
    addRoute(method: .get, path: "", middleware: middleware, responder: responder)
  }

  func root(middleware: Middleware..., respond: Respond) {
    addRoute(method: .get, path: "", middleware: middleware, responder: BasicResponder(respond))
  }

  func resources(_ name: String, middleware: Middleware..., controller: ResourceController) {
    get(name, respond: controller.index)
    get(name + "/new", respond: controller.new)
    get(name + "/:id", respond: controller.show)
    get(name + "/:id/edit", respond: controller.edit)
    post(name, respond: controller.create)
    delete(name + "/:id", respond: controller.destroy)
    patch(name + "/:id", respond: controller.update)
  }

  func compose(_ path: String = "", build: (builder: RouteMap) -> Void) {
    let router = Router(build: build)
    compose(path, router: router)
  }
}
