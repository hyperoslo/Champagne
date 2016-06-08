import Flamingo

public class BirdController: ResourceController {

  public required init() {}

  public func index(request: Request) throws -> Response {
    return render("index")
  }

  public func show(request: Request) throws -> Response {
    return render("info")
  }
}
