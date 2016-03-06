@testable import Flamingo
import Quick
import Nimble

class RequestSpec: QuickSpec {

  typealias Method = Request.Method

  override func spec() {
    describe("Request") {
      var request: Request!
      let headers = ["Accept" : "application/json"]
      let body: [UInt8] = [0, 1]

      beforeEach {
        request = Request(method: .GET, path: "/items?order=asc", headers: headers, body: body)
      }

      describe("#init") {
        it("sets properties") {
          expect(request.method).to(equal(Method.GET))
          expect(request.body).to(equal(body))
          expect(request.headers).to(equal(headers))
        }

        context("with a query in the path") {
          it("sets a correct path") {
            expect(request.path).to(equal("/items"))
          }
        }

        context("without a query in the path") {
          it("sets a correct path") {
            request = Request(method: .GET, path: "/items", headers: headers, body: body)

            expect(request.path).to(equal("/items"))
          }
        }

        context("with no host in headers") {
          it("sets hostname to *") {
            expect(request.hostname).to(equal("*"))
          }
        }

        context("with a host in headers") {
          it("adds content type header") {
            let host = "www.hyper.no"
            request = Request(method: .GET, path: "/items?order=asc",
              headers: ["host": host], body: body)

            expect(request.hostname).to(equal(host))
          }
        }
      }
    }
  }
}
