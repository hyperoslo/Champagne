@testable import Flamingo
import Quick
import Nimble

class RouteSpec: QuickSpec {

  override func spec() {
    describe("Route") {
      var route: Route!
      let controller = TestResourceController()

      beforeEach {
        route = Route(path: "/cats", method: .GET, action: controller.index)
      }

      describe("#hashValue") {
        it("returns a valid hash value") {
          expect(route.hashValue).to(equal("\(route.method.rawValue) \(route.path)".hashValue))
        }
      }

      describe("==") {
        it("equals to the route with same method and path") {
          let testRoute = Route(path: "/cats", method: .GET, action: controller.index)
          expect(route).to(equal(testRoute))
        }

        it("does not equal to the route with different method") {
          let testRoute = Route(path: "/cats", method: .POST, action: controller.index)
          expect(route).toNot(equal(testRoute))
        }

        it("does not equal to the route with different path") {
          let testRoute = Route(path: "/kittens", method: .GET, action: controller.index)
          expect(route).toNot(equal(testRoute))
        }
      }
    }
  }
}
