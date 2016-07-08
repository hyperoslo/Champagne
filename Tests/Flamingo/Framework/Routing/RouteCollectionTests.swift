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

  lazy var collection: RouteCollection = RouteCollection(path: self.rootPath)

  override func setUp() {
    super.setUp()
    collection.clear()
  }

  // MARK: - Tests

  func testInit() {
    XCTAssertEqual(collection.path, rootPath)
    XCTAssertTrue(collection.routes.isEmpty)
  }

  func testAdd() {
    collection.add(method: .get, path: path, middleware: middleware, responder: responder)
    collection.add(method: .post, path: path, middleware: middleware, responder: responder)

    XCTAssertEqual(collection.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(collection.routes.count, 1)
    XCTAssertEqual(collection.routes.first?.actions.count, 2)

    respond(to: collection.routes.first?.actions[.get], with: .ok)
    respond(to: collection.routes.first?.actions[.post], with: .ok)
  }

  func testFallback() {
    collection.add(method: .get, path: path, middleware: middleware, responder: responder)
    collection.fallback(on: path, middleware: middleware, responder: failResponder)

    XCTAssertEqual(collection.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(collection.routes.count, 1)

    respond(to: collection.routes.first?.fallback, with: .notFound)
  }

  func testClear() {
    collection.add(method: .get, path: path, middleware: middleware, responder: responder)
    XCTAssertEqual(collection.routes.count, 1)

    collection.clear()
    XCTAssertTrue(collection.routes.isEmpty)
  }

  func testGet() {
    collection.get(path, middleware: middleware, responder: responder)
    collection.get(path, middleware: middleware, responder: responder)
    collection.get(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(collection.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(collection.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(collection.routes.count, 2)
    XCTAssertEqual(collection.routes.first?.actions.count, 1)
    XCTAssertEqual(collection.routes.last?.actions.count, 1)

    respond(to: collection.routes.first?.actions[.get], with: .ok)
    respond(to: collection.routes.last?.actions[.get], with: .ok)
  }

  func testPost() {
    collection.post(path, middleware: middleware, responder: responder)
    collection.post(path, middleware: middleware, responder: responder)
    collection.post(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(collection.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(collection.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(collection.routes.count, 2)
    XCTAssertEqual(collection.routes.first?.actions.count, 1)
    XCTAssertEqual(collection.routes.last?.actions.count, 1)

    respond(to: collection.routes.first?.actions[.post], with: .ok)
    respond(to: collection.routes.last?.actions[.post], with: .ok)
  }

  func testPut() {
    collection.put(path, middleware: middleware, responder: responder)
    collection.put(path, middleware: middleware, responder: responder)
    collection.put(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(collection.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(collection.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(collection.routes.count, 2)
    XCTAssertEqual(collection.routes.first?.actions.count, 1)
    XCTAssertEqual(collection.routes.last?.actions.count, 1)

    respond(to: collection.routes.first?.actions[.put], with: .ok)
    respond(to: collection.routes.last?.actions[.put], with: .ok)
  }

  func testPatch() {
    collection.patch(path, middleware: middleware, responder: responder)
    collection.patch(path, middleware: middleware, responder: responder)
    collection.patch(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(collection.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(collection.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(collection.routes.count, 2)
    XCTAssertEqual(collection.routes.first?.actions.count, 1)
    XCTAssertEqual(collection.routes.last?.actions.count, 1)

    respond(to: collection.routes.first?.actions[.patch], with: .ok)
    respond(to: collection.routes.last?.actions[.patch], with: .ok)
  }

  func testDelete() {
    collection.delete(path, middleware: middleware, responder: responder)
    collection.delete(path, middleware: middleware, responder: responder)
    collection.delete(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(collection.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(collection.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(collection.routes.count, 2)
    XCTAssertEqual(collection.routes.first?.actions.count, 1)
    XCTAssertEqual(collection.routes.last?.actions.count, 1)

    respond(to: collection.routes.first?.actions[.delete], with: .ok)
    respond(to: collection.routes.last?.actions[.delete], with: .ok)
  }

  func testOptions() {
    collection.options(path, middleware: middleware, responder: responder)
    collection.options(path, middleware: middleware, responder: responder)
    collection.options(path2, middleware: middleware, responder: responder)

    XCTAssertEqual(collection.routeFor(relativePath: path)?.path, "/" + path)
    XCTAssertEqual(collection.routeFor(relativePath: path2)?.path, "/" + path2)
    XCTAssertEqual(collection.routes.count, 2)
    XCTAssertEqual(collection.routes.first?.actions.count, 1)
    XCTAssertEqual(collection.routes.last?.actions.count, 1)

    respond(to: collection.routes.first?.actions[.options], with: .ok)
    respond(to: collection.routes.last?.actions[.options], with: .ok)
  }

  func testRoot() {
    collection.root(middleware: middleware, responder: responder)

    XCTAssertEqual(collection.routeFor(relativePath: "/")?.path, "/")
    XCTAssertEqual(collection.routes.count, 1)
    XCTAssertEqual(collection.routes.first?.actions.count, 1)

    respond(to: collection.routes.first?.actions[.get], with: .ok)
  }

  func testNamespaceWithBuild() {
    let namespace = "group"
    let routePath = "/\(namespace)/\(self.path)"

    collection.namespace(namespace, middleware: middleware) { map in
      map.get(self.path, responder: self.responder)
      map.post(self.path, responder: self.responder)
      map.fallback(responder: self.failResponder)
    }

    XCTAssertEqual(collection.routeFor(absolutePath: routePath)?.path, routePath)
    XCTAssertEqual(collection.routes.count, 2)
    XCTAssertEqual(collection.routes.first?.actions.count, 2)
    XCTAssertEqual(collection.routes.last?.actions.count, 0)

    respond(to: collection.routes.first?.actions[.get], with: .ok)
    respond(to: collection.routes.first?.actions[.post], with: .ok)
    respond(to: collection.routes.last?.fallback, with: .notFound)
  }

  func testNamespaceWithController() {
    let namespace = "group"

    collection.namespace(namespace) {
      return self.bubble.controller(MainController.self)
    }

    XCTAssertEqual(collection.routeFor(absolutePath: "/\(namespace)")?.path, "/\(namespace)")
    XCTAssertEqual(collection.routeFor(absolutePath: "/\(namespace)/info")?.path, "/\(namespace)/info")
    XCTAssertEqual(collection.routes.count, 2)
    XCTAssertEqual(collection.routes.first?.actions.count, 1)
    XCTAssertEqual(collection.routes.last?.actions.count, 1)

    respond(to: collection.routes.first?.actions[.get], with: .ok)
    respond(to: collection.routes.last?.actions[.get], with: .ok)
  }

  func testResources() {
    let name = "resource"

    collection.resources(name) {
      return self.bubble.controller(ResourceController.self)
    }

    XCTAssertEqual(collection.routes.count, 4)
    XCTAssertEqual(collection.routeFor(relativePath: name)?.path, "/\(name)")
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/new")?.path, "/\(name)/new")
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/:id/edit")?.path, "/\(name)/:id/edit")
    XCTAssertEqual(collection.routes.first?.actions.count, 2)
    XCTAssertEqual(collection.routes[1].actions.count, 1)
    XCTAssertEqual(collection.routes[2].actions.count, 3)
    XCTAssertEqual(collection.routes.last?.actions.count, 1)
  }

  func testResourcesWithOnly() {
    let name = "resource"

    collection.resources(name, only: [.index, .show]) {
      return self.bubble.controller(ResourceController.self)
    }

    XCTAssertEqual(collection.routes.count, 2)
    XCTAssertEqual(collection.routeFor(relativePath: name)?.path, "/\(name)")
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")
    XCTAssertEqual(collection.routes.first?.actions.count, 1)
    XCTAssertEqual(collection.routes.last?.actions.count, 1)
  }

  func testResourcesWithExcept() {
    let name = "resource"

    collection.resources(name, except: [.index, .show]) {
      return self.bubble.controller(ResourceController.self)
    }

    XCTAssertEqual(collection.routes.count, 4)
    XCTAssertEqual(collection.routeFor(relativePath: name)?.path, "/\(name)")
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/new")?.path, "/\(name)/new")
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/:id/edit")?.path, "/\(name)/:id/edit")
    XCTAssertEqual(collection.routes.first?.actions.count, 1)
    XCTAssertEqual(collection.routes[1].actions.count, 1)
    XCTAssertEqual(collection.routes[2].actions.count, 1)
    XCTAssertEqual(collection.routes.last?.actions.count, 2)
  }

  func testAddResourceAction() {
    let name = "resource"
    let factory = {
      return self.bubble.controller(ResourceController.self)
    }

    collection.addResourceAction(.index, on: name, factory: factory)
    XCTAssertEqual(collection.routes.count, 1)
    XCTAssertEqual(collection.routeFor(relativePath: name)?.path, "/\(name)")

    collection.clear()
    collection.addResourceAction(.new, on: name, factory: factory)
    XCTAssertEqual(collection.routes.count, 1)
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/new")?.path, "/\(name)/new")

    collection.clear()
    collection.addResourceAction(.show, on: name, factory: factory)
    XCTAssertEqual(collection.routes.count, 1)
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")

    collection.clear()
    collection.addResourceAction(.edit, on: name, factory: factory)
    XCTAssertEqual(collection.routes.count, 1)
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/:id/edit")?.path, "/\(name)/:id/edit")

    collection.clear()
    collection.addResourceAction(.create, on: name, factory: factory)
    XCTAssertEqual(collection.routes.count, 1)
    XCTAssertEqual(collection.routeFor(relativePath: name)?.path, "/\(name)")

    collection.clear()
    collection.addResourceAction(.destroy, on: name, factory: factory)
    XCTAssertEqual(collection.routes.count, 1)
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")

    collection.clear()
    collection.addResourceAction(.update, on: name, factory: factory)
    XCTAssertEqual(collection.routes.count, 1)
    XCTAssertEqual(collection.routeFor(relativePath: "\(name)/:id")?.path, "/\(name)/:id")
  }

  func testUse() {
    collection.use {
      self.bubble.controller(MainController.self)
    }

    XCTAssertEqual(collection.routes.count, 2)
    XCTAssertEqual(collection.routeFor(relativePath: "/")?.path, "/")
    XCTAssertEqual(collection.routeFor(relativePath: "info")?.path, "/info")
    XCTAssertEqual(collection.routes.first?.actions.count, 1)
    XCTAssertEqual(collection.routes.last?.actions.count, 1)
  }
}
