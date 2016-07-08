// MARK: - GET routes

public protocol RouteGetBuilding: RouteBuilding {

  /**
    Registers `GET /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: Respond method.
  */
  func get(_ path: String, middleware: [Middleware], respond: Respond)

  /**
    Registers `GET /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func get(_ path: String, middleware: [Middleware], responder: Responder)
}

public extension RouteGetBuilding {

  func get(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    get(path, middleware: middleware, responder: BasicResponder(respond))
  }

  func get(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .get, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - POST routes

public protocol RoutePostBuilding: RouteBuilding {

  /**
    Registers `POST /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: Respond method.
  */
  func post(_ path: String, middleware: [Middleware], respond: Respond)

  /**
    Registers `POST /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func post(_ path: String, middleware: [Middleware], responder: Responder)
}

public extension RoutePostBuilding {

  func post(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    post(path, middleware: middleware, responder: BasicResponder(respond))
  }

  func post(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .post, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - PUT routes

public protocol RoutePutBuilding: RouteBuilding {

  /**
    Registers `PUT /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: Respond method.
  */
  func put(_ path: String, middleware: [Middleware], respond: Respond)

  /**
    Registers `PUT /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func put(_ path: String, middleware: [Middleware], responder: Responder)
}

public extension RoutePutBuilding {

  func put(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    put(path, middleware: middleware, responder: BasicResponder(respond))
  }


  func put(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .put, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - PATCH routes

public protocol RoutePatchBuilding: RouteBuilding {

  /**
    Registers `PATCH /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: Respond method.
  */
  func patch(_ path: String, middleware: [Middleware], respond: Respond)

  /**
    Registers `PATCH /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func patch(_ path: String, middleware: [Middleware], responder: Responder)
}

public extension RoutePatchBuilding {

  func patch(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    patch(path, middleware: middleware, responder: BasicResponder(respond))
  }


  func patch(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .patch, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - DELETE routes

public protocol RouteDeleteBuilding: RouteBuilding {

  /**
    Registers `DELETE /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: Respond method.
  */
  func delete(_ path: String, middleware: [Middleware], respond: Respond)

  /**
    Registers `DELETE /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func delete(_ path: String, middleware: [Middleware], responder: Responder)
}

public extension RouteDeleteBuilding {

  func delete(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    delete(path, middleware: middleware, responder: BasicResponder(respond))
  }

  func delete(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .delete, path: path, middleware: middleware, responder: responder)
  }
}

// MARK: - OPTIONS routes

public protocol RouteOptionsBuilding: RouteBuilding {

  /**
    Registers `OPTIONS /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter respond: Respond method.
  */
  func options(_ path: String, middleware: [Middleware], respond: Respond)

  /**
    Registers `OPTIONS /path` route.

    - Parameter path: Route path.
    - Parameter middleware: Route-specific middleware.
    - Parameter responder: The responder.
  */
  func options(_ path: String, middleware: [Middleware], responder: Responder)
}

public extension RouteOptionsBuilding {

  func options(_ path: String, middleware: [Middleware] = [], respond: Respond) {
    options(path, middleware: middleware, responder: BasicResponder(respond))
  }


  func options(_ path: String, middleware: [Middleware] = [], responder: Responder) {
    add(method: .options, path: path, middleware: middleware, responder: responder)
  }
}
