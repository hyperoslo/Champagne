import Flamingo

public class BirdController: ResourceController {

  let birds: [Bird]

  public required init() {
    birds = [
      Bird(id: "1", name: "Swift", family: "Apodidae"),
      Bird(id: "2", name: "Flamingo", family: "Phoenicopteridae")
    ]
  }

  public func index(request: Request) throws -> Response {
    let templateContext: [String: Any] = ["birds": birds.map({ $0.dictionary })]

    return respond(to: request, [
      .html: { self.render(context: templateContext) },
      .json: { self.render(json: templateContext) }
    ])
  }

  public func show(request: Request) throws -> Response {
    guard let id = request.pathParameters["id"],
      bird = birds.filter({ $0.id == id }).first
      else { return Response(status: .notFound) }

    return respond(to: request, [
      .html: { self.render(context: bird.dictionary) },
      .json: { self.render(json: bird.dictionary) }
    ])
  }
}
