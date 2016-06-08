// MARK: - GET routes

public protocol RouteGetBuilding: RouteBuilding {}

public extension RouteGetBuilding {

  /**
    Registers `GET /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: The responder.
  */
  func get(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    get(path, middleware: middleware, responder: BasicResponder(respond))
  }

  /**
    Registers `GET /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func get(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .get, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - POST routes

public protocol RoutePostBuilding: RouteBuilding {}

public extension RoutePostBuilding {

  /**
    Registers `POST /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: The responder.
  */
  func post(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    post(path, middleware: middleware, responder: BasicResponder(respond))
  }

  /**
    Registers `POST /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func post(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .post, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - PUT routes

public protocol RoutePutBuilding: RouteBuilding {}

public extension RoutePutBuilding {

  /**
    Registers `PUT /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: The responder.
  */
  func put(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    put(path, middleware: middleware, responder: BasicResponder(respond))
  }

  /**
    Registers `PUT /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func put(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .put, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - PATCH routes

public protocol RoutePatchBuilding: RouteBuilding {}

public extension RoutePatchBuilding {

  /**
    Registers `PATCH /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func patch(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    patch(path, middleware: middleware, responder: BasicResponder(respond))
  }

  /**
    Registers `PATCH /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func patch(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .patch, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - DELETE routes

public protocol RouteDeleteBuilding: RouteBuilding {}

public extension RouteDeleteBuilding {

  /**
    Registers `DELETE /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: The responder.
  */
  func delete(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    delete(path, middleware: middleware, responder: BasicResponder(respond))
  }

  /**
    Registers `DELETE /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func delete(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .delete, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - OPTIONS routes

public protocol RouteOptionsBuilding: RouteBuilding {}

public extension RouteOptionsBuilding {

  /**
    Registers `OPTIONS /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: The responder.
  */
  func options(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    options(path, middleware: middleware, responder: BasicResponder(respond))
  }

  /**
    Registers `OPTIONS /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func options(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .options, path: path, middleware: middleware, responder: responder)
  }
}
