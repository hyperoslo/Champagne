@testable import Flamingo
import Quick
import Nimble

class RouterSpec: QuickSpec {

  override func spec() {
    describe("Router") {
      var router: Router!
      let controller = TestResourceController()

      beforeEach {
        router = Router()
      }

      describe("#resources") {
        beforeEach {
          router.resources("cats", controller: controller)
        }

        it("adds all resource routes") {
          expect(router.routes.filter({ self.isRoute($1, "/cats", .GET) }).count).to(equal(1))
          expect(router.routes.filter({ self.isRoute($1, "/cats/new", .GET) }).count).to(equal(1))
          expect(router.routes.filter({ self.isRoute($1, "/cats/{id}", .GET) }).count).to(equal(1))
          expect(router.routes.filter({ self.isRoute($1, "/cats/{id}/edit", .GET) }).count).to(equal(1))
          expect(router.routes.filter({ self.isRoute($1, "/cats", .POST) }).count).to(equal(1))
          expect(router.routes.filter({ self.isRoute($1, "/cats/{id}", .DELETE) }).count).to(equal(1))
          expect(router.routes.filter({ self.isRoute($1, "/cats/{id}", .PATCH) }).count).to(equal(1))
        }
      }

      describe("#get") {
        it("adds GET route") {
          router.get("/cats", controller.index)
          expect(router.routes.filter({ self.isRoute($1, "/cats", .GET) }).count).to(equal(1))
        }
      }

      describe("#post") {
        it("adds POST route") {
          router.post("/cats", controller.index)
          expect(router.routes.filter({ self.isRoute($1, "/cats", .POST) }).count).to(equal(1))
        }
      }

      describe("#put") {
        it("adds PUT route") {
          router.post("/cats", controller.index)
          expect(router.routes.filter({ self.isRoute($1, "/cats", .POST) }).count).to(equal(1))
        }
      }

      describe("#patch") {
        it("adds PATCH route") {
          router.patch("/cats/{id}", controller.index)
          expect(router.routes.filter({ self.isRoute($1, "/cats/{id}", .PATCH) }).count).to(equal(1))
        }
      }

      describe("#delete") {
        it("adds DELETE route") {
          router.delete("/cats/{id}", controller.destroy)
          expect(router.routes.filter({ self.isRoute($1, "/cats/{id}", .DELETE) }).count).to(equal(1))
        }
      }

      describe("#head") {
        it("adds HEAD route") {
          router.head("/cats", controller.index)
          expect(router.routes.filter({ self.isRoute($1, "/cats", .HEAD) }).count).to(equal(1))
        }
      }

      describe("#options") {
        it("adds OPTIONS route") {
          router.options("/cats", controller.index)
          expect(router.routes.filter({ self.isRoute($1, "/cats", .OPTIONS) }).count).to(equal(1))
        }
      }

      describe("#add") {
        it("adds a route to the dictionary of routes") {
          var route = Route(path: "/cats", method: .GET, action: controller.index)
          router.add(route)

          expect(router.routes.filter({ self.isRoute($1, "/cats", .GET) }).count).to(equal(1))

          route = Route(path: "/cats", method: .POST, action: controller.index)
          router.add(route)

          expect(router.routes.filter({ self.isRoute($1, "/cats", .GET) }).count).to(equal(1))
        }
      }
    }
  }

  func isRoute(route: Route, _ path: String, _ method: Request.Method) -> Bool {
    return route.path == path && route.method == method
  }
}
