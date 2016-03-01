import Inquiline

public class Controller {

  public typealias Action = (request: Request) -> Response

  var actions = [String: Action]()

  public init() {}
}
