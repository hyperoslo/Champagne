@testable import Flamingo
import Quick
import Nimble

class ResponseSpec: QuickSpec {

  typealias Status = Response.Status
  typealias ContentType = Response.ContentType

  override func spec() {
    describe("Response") {
      var response: Response!

      beforeEach {
        response = Response(status: .Ok, data: [0, 1], contentType: .JSON)
      }

      describe("#init") {
        it("sets properties") {
          expect(response.status).to(equal(Status.Ok))
          expect(response.data).to(equal([0, 1]))
        }

        it("adds Server header") {
          expect(response.headers["Server"]).to(equal("Flamingo \(Application.version)"))
        }

        context("with no content type") {
          it("does not add content type header") {
            response = Response(status: .Ok, data: [0, 1], contentType: .None)
            expect(response.headers["Content-Type"]).to(beNil())
          }
        }

        context("with a content type") {
          it("adds content type header") {
            response = Response(status: .Ok, data: [0, 1], contentType: .JSON)
            expect(response.headers["Content-Type"]).to(equal(ContentType.JSON.value))
          }
        }
      }
    }
  }
}
