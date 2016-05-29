import HTTP

public final class RouteContainer {
  let path: String
  var routes: [Route] = []

  init(path: String = "") {
    self.path = path
  }

  // MARK: Add routes

  // public func add(method: Method, path: String, middleware: Middleware..., responder: Responder) {
  //   add(method: method, path: path, middleware: middleware, responder: responder)
  // }

  public func add(method: Method, path: String, middleware: [Middleware], responder: Responder) {
    let action = middleware.chain(to: responder)
    let path = path.hasPrefix("/") ? String(path.characters.dropFirst()) : path
    let routePath = self.path + "/" + path

    if let route = route(for: routePath) {
      route.addAction(method: method, action: action)
    } else {
      let route = BasicRoute(path: routePath, actions: [method: action])
      routes.append(route)
    }
  }

  private func route(for path: String) -> BasicRoute? {
    return routes.filter({ $0.path == path }).first as? BasicRoute
  }
}

// MARK: - GET routes

extension RouteContainer {

  public func get(_ path: String, middleware: Middleware..., responder: Responder) {
    get(path, middleware: middleware, responder: responder)
  }

  public func get(_ path: String, middleware: Middleware..., respond: Respond) {
    get(path, middleware: middleware, responder: BasicResponder(respond))
  }

  private func get(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .get, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - POST routes

extension RouteContainer {

  public func post(_ path: String, middleware: Middleware..., responder: Responder) {
    post(path, middleware: middleware, responder: responder)
  }

  public func post(_ path: String, middleware: Middleware..., respond: Respond) {
    post(path, middleware: middleware, responder: BasicResponder(respond))
  }

  private func post(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .post, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - PUT routes

extension RouteContainer {

  public func put(_ path: String, middleware: Middleware..., responder: Responder) {
    put(path, middleware: middleware, responder: responder)
  }

  public func put(_ path: String, middleware: Middleware..., respond: Respond) {
    put(path, middleware: middleware, responder: BasicResponder(respond))
  }

  private func put(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .put, path: path, middleware: middleware, responder: responder)
  }
}

extension RouteContainer {

  public func patch(_ path: String, middleware: Middleware..., responder: Responder) {
    patch(path, middleware: middleware, responder: responder)
  }

  public func patch(_ path: String, middleware: Middleware..., respond: Respond) {
    patch(path, middleware: middleware, responder: BasicResponder(respond))
  }

  private func patch(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .patch, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - DELETE routes

extension RouteContainer {

  public func delete(_ path: String, middleware: Middleware..., responder: Responder) {
    delete(path, middleware: middleware, responder: responder)
  }

  public func delete(_ path: String, middleware: Middleware..., respond: Respond) {
    delete(path, middleware: middleware, responder: BasicResponder(respond))
  }

  private func delete(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .delete, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - OPTIONS routes

extension RouteContainer {

  public func options(_ path: String, middleware: Middleware..., responder: Responder) {
    options(path, middleware: middleware, responder: responder)
  }

  public func options(_ path: String, middleware: Middleware..., respond: Respond) {
    options(path, middleware: middleware, responder: BasicResponder(respond))
  }

  private func options(_ path: String, middleware: [Middleware], responder: Responder) {
    add(method: .options, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - Route fallbacks

extension RouteContainer {

  public func fallback(_ path: String = "", middleware: Middleware..., respond: Respond) {
    fallback(path, middleware: middleware, responder: BasicResponder(respond))
  }

  public func fallback(_ path: String = "", middleware: [Middleware], responder: Responder) {
    let fallback = middleware.chain(to: responder)
    let routePath = self.path + path

    if let route = route(for: routePath) {
      route.fallback = fallback
    } else {
      let route = BasicRoute(path: path, fallback: fallback)
      routes.append(route)
    }
  }
}

// MARK: - Resources

extension RouteContainer {

  public func root(middleware: Middleware..., responder: Responder) {
    add(method: .get, path: "", middleware: middleware, responder: responder)
  }

  public func root(middleware: Middleware..., respond: Respond) {
    add(method: .get, path: "", middleware: middleware, responder: BasicResponder(respond))
  }

  public func resources(_ name: String, middleware: Middleware..., controller: ResourceController) {
    get(name, respond: controller.index)
    get(name + "/new", respond: controller.new)
    get(name + "/:id", respond: controller.show)
    get(name + "/:id/edit", respond: controller.edit)
    post(name, respond: controller.create)
    delete(name + "/:id", respond: controller.destroy)
    patch(name + "/:id", respond: controller.update)
  }
}

// MARK: - Namespace

extension RouteContainer {

  public func namespace(_ path: String, middleware: Middleware..., build: (container: RouteContainer) -> Void) {
    let container = RouteContainer(path: path)

    build(container: container)

    for route in container.routes {
      for (method, action) in route.actions {
        add(method: method,
          path: route.path,
          middleware: middleware,
          responder: action
        )
      }
    }
  }
}
