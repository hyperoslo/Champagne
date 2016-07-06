import Flamingo

class BirdController: Controller, ResourceFactory {

  let birds: [Bird] = [
    Bird(id: "1", name: "Swift", family: "Apodidae"),
    Bird(id: "2", name: "Flamingo", family: "Phoenicopteridae")
  ]

  func index(request: Request) throws -> Response {
    let context: [String: Any] = ["birds": birds.map({ $0.dictionary })]

    return respond(to: request, [
      .html: { self.render(context: context) },
      .json: { self.render(json: context) }
    ])
  }

  func show(request: Request) throws -> Response {
    guard let id = request.pathParameters["id"],
      bird = birds.filter({ $0.id == id }).first
      else { return Response(status: .notFound) }

    return respond(to: request, [
      .html: { self.render(context: bird.dictionary) },
      .json: { self.render(json: bird.dictionary) }
    ])
  }
}
