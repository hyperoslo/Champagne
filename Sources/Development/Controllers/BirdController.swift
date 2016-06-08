import Flamingo

public class BirdController: ResourceController {

  public required init() {}

  public func index(request: Request) throws -> Response {
    return render("index")
  }

  public func show(request: Request) throws -> Response {
    return render("index")
  }

  public func new(request: Request) throws -> Response {
    return render("index")
  }

  public func create(request: Request) throws -> Response {
    return render("index")
  }

  public func edit(request: Request) throws -> Response {
    return render("index")
  }

  public func update(request: Request) throws -> Response {
    return render("index")
  }

  public func destroy(request: Request) throws -> Response {
    return render("index")
  }
}
