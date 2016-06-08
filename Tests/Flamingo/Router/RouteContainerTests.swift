import XCTest
@testable import Flamingo

class RouteContainerTests: XCTestCase, TestResponding {

  static var allTests: [(String, (RouteContainerTests) -> () throws -> Void)] {
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
      ("testNamespace", testNamespace),
      ("testResources", testResources)
    ]
  }

  let rootPath = "/"
  let path = "test"
  let path2 = "test2"

  let middleware: [Middleware] = [
    ParametersMiddleware(),
    ErrorMiddleware()
  ]

  let responder = BasicResponder { _ in
    Response(status: .ok, body: Data(""))
  }

  let failResponder = BasicResponder { _ in
    Response(status: .notFound, body: Data(""))
  }

  lazy var container: RouteContainer = RouteContainer(path: self.rootPath)

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

  func testNamespace() {
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

  func testResources() {
    let name = "resource"

    container.resources(name, controller: TestResourceController.self)

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

  func testUse() {
    let name = "resource"

    container.use(name, controller: TestRoutingController.self)

    XCTAssertEqual(container.routes.count, 2)
    XCTAssertEqual(container.routeFor(relativePath: name)?.path, "/\(name)")
    XCTAssertEqual(container.routeFor(relativePath: "\(name)/info")?.path, "/\(name)/info")
    XCTAssertEqual(container.routes.first?.actions.count, 1)
    XCTAssertEqual(container.routes.last?.actions.count, 1)
  }
}
