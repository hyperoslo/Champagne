import Champagne

class BirdController: Controller, ResourceResponseFactory {

  let birds: [Bird] = [
    Bird(id: "1", name: "Swift", family: "Apodidae"),
    Bird(id: "2", name: "Champagne", family: "Phoenicopteridae")
  ]

  func index(request: Request) throws -> Response {
    let context: [String: Any] = ["birds": birds.map({ $0.dictionary })]

    return respond(to: request, [
      .html: { self.render(context: context) },
      .json: { self.render(json: context) }
    ])
  }

  func show(request: Request) throws -> Response {
    guard let id = request.parameters["id"],
      bird = birds.filter({ $0.id == id }).first
      else { return Response(status: .notFound) }

    return respond(to: request, [
      .html: { self.render(context: bird.dictionary) },
      .json: { self.render(json: bird.dictionary) }
    ])
  }
}
