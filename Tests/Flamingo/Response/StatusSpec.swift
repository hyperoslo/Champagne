@testable import Flamingo
import Quick
import Nimble

class StatusSpec: QuickSpec {

  typealias Status = Response.Status

  override func spec() {
    describe("ContentType") {
      var status: Status!

      describe("#description") {
        it("returns string description") {
          status = .Ok
          expect(status.description).to(equal("\(status.code) \(status.reason)"))

          status = .Unauthorized
          expect(status.description).to(equal("\(status.code) \(status.reason)"))
        }
      }

      describe("#code") {
        it("returns rawValue") {
          status = .Ok
          expect(status.code).to(equal(status.rawValue))

          status = .Unauthorized
          expect(status.code).to(equal(status.rawValue))
        }
      }
    }
  }
}
