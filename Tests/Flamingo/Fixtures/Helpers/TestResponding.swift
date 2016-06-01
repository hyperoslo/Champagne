import XCTest
@testable import Flamingo

protocol TestResponding {
  func respond(to responder: Responder?, with status: Status)
}

extension TestResponding {

  func respond(to responder: Responder?, with status: Status) {
    let request = Request()

    do {
      let response = try responder?.respond(to: request)
      XCTAssertEqual(response?.status, status)
    } catch {
      XCTFail("\(responder) throws an error.")
    }
  }
}
