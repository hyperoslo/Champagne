@_exported import HTTP

/**
  Route container keeps and builds routes relative to the root path.
*/
public class RouteContainer: RouteBuilding {
  /// Root path.
  public let path: String

  /// List of registerd routes.
  public var routes: [Route] = []

  /// Append leading slash to the route path
  public var appendLeadingSlash = true

  /// Append trailing slash to the route path
  public var appendTrailingSlash = false

  /**
    Creates a new `RouteContainer` instance.

    - Parameter path: The root path..
  */
  public init(path: String = "") {
    self.path = path
  }

  /**
    Builds a route and adds responder as an action on the corresponding method.

    - Parameter method: The request method.
    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func add(method: Request.Method, path: String, middleware: [Middleware], responder: Responder) {
    let action = middleware.chain(to: responder)
    let path = absolutePathFor(path)

    if let route = routeFor(absolutePath: path) {
      route.addAction(method: method, action: action)
    } else {
      let route = BasicRoute(path: path, actions: [method: action])
      routes.append(route)
    }
  }

  /**
    Adds a fallback on a given path.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func fallback(on path: String, middleware: [Middleware], responder: Responder) {
    let fallback = middleware.chain(to: responder)
    let path = absolutePathFor(path)

    if let route = routeFor(absolutePath: path) {
      route.fallback = fallback
    } else {
      let route = BasicRoute(path: path, fallback: fallback)
      routes.append(route)
    }
  }

  /**
    Adds a fallback on a given path.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func fallback(_ path: String = "", middleware: Middleware..., respond: Respond) {
    fallback(on: path, middleware: middleware, responder: BasicResponder(respond))
  }

  public func fallback(_ path: String = "", middleware: Middleware..., responder: Responder) {
    fallback(on: path, middleware: middleware, responder: responder)
  }

  /**
    Removes all routes
  */
  public func clear() {
    routes.removeAll()
  }
}

// MARK: - GET routes

extension RouteContainer {

  /**
    Registers `GET /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func get(_ path: String, middleware: Middleware..., responder: Responder) {
    add(method: .get, path: path, middleware: middleware, responder: responder)
  }

  /**
    Registers `GET /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func get(_ path: String, middleware: Middleware..., respond: Respond) {
    get(path, middleware: middleware, responder: BasicResponder(respond))
  }
}

// MARK: - POST routes

extension RouteContainer {

  /**
    Registers `POST /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func post(_ path: String, middleware: Middleware..., responder: Responder) {
    post(path, middleware: middleware, responder: responder)
  }

  /**
    Registers `POST /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func post(_ path: String, middleware: Middleware..., respond: Respond) {
    post(path, middleware: middleware, responder: BasicResponder(respond))
  }
}

// MARK: - PUT routes

extension RouteContainer {

  /**
    Registers `PUT /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func put(_ path: String, middleware: Middleware..., responder: Responder) {
    put(path, middleware: middleware, responder: responder)
  }

  /**
    Registers `PUT /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func put(_ path: String, middleware: Middleware..., respond: Respond) {
    put(path, middleware: middleware, responder: BasicResponder(respond))
  }
}

// MARK: - PATCH routes

extension RouteContainer {

  /**
    Registers `PATCH /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func patch(_ path: String, middleware: Middleware..., responder: Responder) {
    patch(path, middleware: middleware, responder: responder)
  }

  /**
    Registers `PATCH /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func patch(_ path: String, middleware: Middleware..., respond: Respond) {
    patch(path, middleware: middleware, responder: BasicResponder(respond))
  }
}

// MARK: - DELETE routes

extension RouteContainer {

  /**
    Registers `DELETE /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func delete(_ path: String, middleware: Middleware..., responder: Responder) {
    delete(path, middleware: middleware, responder: responder)
  }

  /**
    Registers `DELETE /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func delete(_ path: String, middleware: Middleware..., respond: Respond) {
    delete(path, middleware: middleware, responder: BasicResponder(respond))
  }
}

// MARK: - OPTIONS routes

extension RouteContainer {

  /**
    Registers `OPTIONS /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func options(_ path: String, middleware: Middleware..., responder: Responder) {
    options(path, middleware: middleware, responder: responder)
  }

  /**
    Registers `OPTIONS /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func options(_ path: String, middleware: Middleware..., respond: Respond) {
    options(path, middleware: middleware, responder: BasicResponder(respond))
  }
}

// MARK: - Extra

extension RouteContainer {

  /**
    Adds a responder on the root path (`GET /`).

    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func root(middleware: Middleware..., responder: Responder) {
    get("", middleware: middleware, responder: responder)
  }

  /**
    Adds a responder on the root path (`GET /`).

    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  public func root(middleware: Middleware..., respond: Respond) {
    get("", middleware: middleware, responder: BasicResponder(respond))
  }

  /**
    Builds a set of routes scoped by the given path.
    Allows to create nested route structures.

    - Parameter path: Namespace path.
    - Parameter middleware: Route-specific middleware.
    - Parameter build: Closure to fill in a new container with routes.
  */
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

      fallback(route.path, responder: route.fallback)
    }
  }

  /**
    Adds resource controller for specified path.

    - Parameter path: Path associated with resource controller.
    - Parameter controller: Controller type to use.
  */
  public func resources<T: ResourceController>(_ path: String, middleware: Middleware..., controller: T.Type) {
    resources(path) {
      return controller.init()
    }
  }

  /**
    Creates standard Index, New, Show, Edit, Create, Destroy and Update routes
    using the respond method from a supplied `ResourceController`.

    - Parameter path: Path associated with resource controller.
    - Parameter middleware: Route-specific middleware.
    - Parameter factory: Closure to instantiate a new instance of controller.
  */
  public func resources<T: ResourceController>(_ path: String,
                                                 middleware: Middleware...,
                                                 buildController factory: () -> T) {
    get(path, respond: factory().index)
    get(path + "/new", respond: factory().new)
    get(path + "/:id", respond: factory().show)
    get(path + "/:id/edit", respond: factory().edit)
    post(path, respond: factory().create)
    delete(path + "/:id", respond: factory().destroy)
    patch(path + "/:id", respond: factory().update)
  }
}
