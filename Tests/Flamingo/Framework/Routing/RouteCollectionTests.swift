import XCTest
@testable import Flamingo

class RouteCollectionTests: XCTestCase, TestResponding {

  static var allTests: [(String, (RouteCollectionTests) -> () throws -> Void)] {
    return [
      ("testInit", testInit),
      ("testAdd", testAdd),
      ("testFallback", testFallback),
      ("testClear", testClear),
      ("testGet", testGet),
      ("testPost", testPost),
      ("testPut", testPut),
      ("testPatch", testPatch),
      ("testDelete", testDelete),
      ("testOptions", testOptions),
      ("testRoot", testRoot),
      ("testNamespaceWithBuild", testNamespaceWithBuild),
      ("testNamespaceWithController", testNamespaceWithController),
      ("testResources", testResources),
      ("testResourcesWithOnly", testResourcesWithOnly),
      ("testResourcesWithExcept", testResourcesWithExcept),
      ("testAddResourceAction", testAddResourceAction),
      ("testUse", testUse)
    ]
  }

  let rootPath = "/"
  let path = "test"
  let path2 = "test2"

  let middleware: [Middleware] = [
    QueryParametersMiddleware(),
    ErrorMiddleware()
  ]

  let responder = BasicResponder { _ in
    Response(status: .ok, body: Data(""))
  }

  let failResponder = BasicResponder { _ in
    Response(status: .notFound, body: Data(""))
  }

  let application = Globals.application

  var bubble: Bubble {
    return application.bubbles[1]
  }

  lazy var container: RouteCollection = RouteCollection(path: self.rootPath)

  override func setUp() {
    super.setUp()
    container.clear()
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(container.path, rootPath)
    XCTAssertTrue(container.routes.isEmpty)
  }

  func testAdd() {
    container.add(method: .get, path: path, middleware: middleware, responder: responder)
    container.add(method: .post, path: path, middleware: middleware, responder: responder)

    XCTAssertEqual(container.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(container.routes.count, 1)
    XCTAssertEqual(container.routes.first?.actions.count, 2)

    respond(to: container.routes.first?.actions[.get], with: .ok)
    respond(to: container.routes.first?.actions[.post], with: .ok)
  }

  func testFallback() {
    container.add(method: .get, path: path, middleware: middleware, responder: responder)
    container.fallback(on: path, middleware: middleware, responder: failResponder)

    XCTAssertEqual(container.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(container.routes.count, 1)

    respond(to: container.routes.first?.fallback, with: .notFound)
  }

  func testClear() {
    container.add(method: .get, path: path, middleware: middleware, responder: responder)
    XCTAssertEqual(container.routes.count, 1)

    container.clear()
    XCTAssertTrue(container.routes.isEmpty)
  }

  func testGet() {
    container.get(path, middleware: middleware, responder: responder)
    container.get(path, middleware: middleware, responder: responder)
    container.get(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(container.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(container.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 1)

    respond(to: container.routes.first?.actions[.get], with: .ok)
    respond(to: container.routes.last?.actions[.get], with: .ok)
  }

  func testPost() {
    container.post(path, middleware: middleware, responder: responder)
    container.post(path, middleware: middleware, responder: responder)
    container.post(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(container.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(container.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 1)

    respond(to: container.routes.first?.actions[.post], with: .ok)
    respond(to: container.routes.last?.actions[.post], with: .ok)
  }

  func testPut() {
    container.put(path, middleware: middleware, responder: responder)
    container.put(path, middleware: middleware, responder: responder)
    container.put(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(container.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(container.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 1)

    respond(to: container.routes.first?.actions[.put], with: .ok)
    respond(to: container.routes.last?.actions[.put], with: .ok)
  }

  func testPatch() {
    container.patch(path, middleware: middleware, responder: responder)
    container.patch(path, middleware: middleware, responder: responder)
    container.patch(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(container.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(container.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 1)

    respond(to: container.routes.first?.actions[.patch], with: .ok)
    respond(to: container.routes.last?.actions[.patch], with: .ok)
  }

  func testDelete() {
    container.delete(path, middleware: middleware, responder: responder)
    container.delete(path, middleware: middleware, responder: responder)
    container.delete(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(container.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(container.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 1)

    respond(to: container.routes.first?.actions[.delete], with: .ok)
    respond(to: container.routes.last?.actions[.delete], with: .ok)
  }

  func testOptions() {
    container.options(path, middleware: middleware, responder: responder)
    container.options(path, middleware: middleware, responder: responder)
    container.options(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(container.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(container.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 1)

    respond(to: container.routes.first?.actions[.options], with: .ok)
    respond(to: container.routes.last?.actions[.options], with: .ok)
  }

  func testRoot() {
    container.root(middleware: middleware, responder: responder)

    XCTAssertEqual(container.routeFor(relativePath: "/")?.path, "/")
    XCTAssertEqual(container.routes.count, 1)
    XCTAssertEqual(container.routes.first?.actions.count, 1)

    respond(to: container.routes.first?.actions[.get], with: .ok)
  }

  func testNamespaceWithBuild() {
    let namespace = "group"
    let routePath = "/\(namespace)/\(self.path)"

    container.namespace(namespace, middleware: middleware) { map in
      map.get(self.path, responder: self.responder)
      map.post(self.path, responder: self.responder)
      map.fallback(responder: self.failResponder)
    }

    XCTAssertEqual(container.routeFor(absolutePath: routePath)?.path, routePath)
    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routes.first?.actions.count, 2)
    XCTAssertEqual(container.routes.last?.actions.count, 0)

    respond(to: container.routes.first?.actions[.get], with: .ok)
    respond(to: container.routes.first?.actions[.post], with: .ok)
    respond(to: container.routes.last?.fallback, with: .notFound)
  }

  func testNamespaceWithController() {
    let namespace = "group"

    container.namespace(namespace) {
      return self.bubble.controller(MainController.self)
    }

    XCTAssertEqual(container.routeFor(absolutePath: "/\(namespace)")?.path, "/\(namespace)")
    XCTAssertEqual(container.routeFor(absolutePath: "/\(namespace)/info")?.path, "/\(namespace)/info")
    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 1)

    respond(to: container.routes.first?.actions[.get], with: .ok)
    respond(to: container.routes.last?.actions[.get], with: .ok)
  }

  func testResources() {
    let name = "resource"

    container.resources(name) {
      return self.bubble.controller(ResourceController.self)
    }

    XCTAssertEqual(container.routes.count, 4)
    XCTAssertEqual(container.routeFor(relativePath: name)?.path, "/\(name)")
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/new")?.path, "/\(name)/new")
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/:id/edit")?.path, "/\(name)/:id/edit")
    XCTAssertEqual(container.routes.first?.actions.count, 2)
    XCTAssertEqual(container.routes[1].actions.count, 1)
    XCTAssertEqual(container.routes[2].actions.count, 3)
    XCTAssertEqual(container.routes.last?.actions.count, 1)
  }

  func testResourcesWithOnly() {
    let name = "resource"

    container.resources(name, only: [.index, .show]) {
      return self.bubble.controller(ResourceController.self)
    }

    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routeFor(relativePath: name)?.path, "/\(name)")
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 1)
  }

  func testResourcesWithExcept() {
    let name = "resource"

    container.resources(name, except: [.index, .show]) {
      return self.bubble.controller(ResourceController.self)
    }

    XCTAssertEqual(container.routes.count, 4)
    XCTAssertEqual(container.routeFor(relativePath: name)?.path, "/\(name)")
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/new")?.path, "/\(name)/new")
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/:id/edit")?.path, "/\(name)/:id/edit")
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes[1].actions.count, 1)
    XCTAssertEqual(container.routes[2].actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 2)
  }

  func testAddResourceAction() {
    let name = "resource"
    let factory = {
      return self.bubble.controller(ResourceController.self)
    }

    container.addResourceAction(.index, on: name, factory: factory)
    XCTAssertEqual(container.routes.count, 1)
    XCTAssertEqual(container.routeFor(relativePath: name)?.path, "/\(name)")

    container.clear()
    container.addResourceAction(.new, on: name, factory: factory)
    XCTAssertEqual(container.routes.count, 1)
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/new")?.path, "/\(name)/new")

    container.clear()
    container.addResourceAction(.show, on: name, factory: factory)
    XCTAssertEqual(container.routes.count, 1)
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")

    container.clear()
    container.addResourceAction(.edit, on: name, factory: factory)
    XCTAssertEqual(container.routes.count, 1)
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/:id/edit")?.path, "/\(name)/:id/edit")

    container.clear()
    container.addResourceAction(.create, on: name, factory: factory)
    XCTAssertEqual(container.routes.count, 1)
    XCTAssertEqual(container.routeFor(relativePath: name)?.path, "/\(name)")

    container.clear()
    container.addResourceAction(.destroy, on: name, factory: factory)
    XCTAssertEqual(container.routes.count, 1)
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")

    container.clear()
    container.addResourceAction(.update, on: name, factory: factory)
    XCTAssertEqual(container.routes.count, 1)
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")
  }

  func testUse() {
    container.use {
      self.bubble.controller(MainController.self)
    }

    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routeFor(relativePath: "/")?.path, "/")
    XCTAssertEqual(container.routeFor(relativePath: "info")?.path, "/info")
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 1)
  }
}
