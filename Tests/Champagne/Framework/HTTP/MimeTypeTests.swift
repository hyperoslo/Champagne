import XCTest
@testable import Champagne

class MimeTypeTests: XCTestCase {

  static var allTests: [(String, (MimeTypeTests) -> () throws -> Void)] {
    return [
      ("testRawValues", testRawValues),
    ]
  }

  // MARK: - Tests

  func testRawValues() {
    XCTAssertEqual(MimeType.html.rawValue, "text/html")
    XCTAssertEqual(MimeType.json.rawValue, "application/json")
    XCTAssertEqual(MimeType.html.rawValue, "text/html")
    XCTAssertEqual(MimeType.text.rawValue, "text/plain")
    XCTAssertEqual(MimeType.js.rawValue, "text/javascript")
    XCTAssertEqual(MimeType.css.rawValue, "text/css")
    XCTAssertEqual(MimeType.ics.rawValue, "text/calendar")
    XCTAssertEqual(MimeType.csv.rawValue, "text/csv")
    XCTAssertEqual(MimeType.vcf.rawValue, "text/vcard")
    XCTAssertEqual(MimeType.png.rawValue, "image/png")
    XCTAssertEqual(MimeType.jpeg.rawValue, "image/jpeg")
    XCTAssertEqual(MimeType.gif.rawValue, "image/gif")
    XCTAssertEqual(MimeType.bmp.rawValue, "image/bmp")
    XCTAssertEqual(MimeType.tiff.rawValue, "image/tiff")
    XCTAssertEqual(MimeType.svg.rawValue, "image/svg+xml")
    XCTAssertEqual(MimeType.mpeg.rawValue, "video/mpeg")
    XCTAssertEqual(MimeType.xml.rawValue, "application/xml")
    XCTAssertEqual(MimeType.rss.rawValue, "application/rss+xml")
    XCTAssertEqual(MimeType.atom.rawValue, "application/atom+xml")
    XCTAssertEqual(MimeType.yaml.rawValue, "application/x-yaml")
    XCTAssertEqual(MimeType.multipartForm.rawValue, "multipart/form-data")
    XCTAssertEqual(MimeType.urlEncodedForm.rawValue, "application/x-www-form-urlencoded")
    XCTAssertEqual(MimeType.json.rawValue, "application/json")
    XCTAssertEqual(MimeType.pdf.rawValue, "application/pdf")
    XCTAssertEqual(MimeType.zip.rawValue, "application/zip")
    XCTAssertEqual(MimeType.gzip.rawValue, "application/gzip")
  }
}
