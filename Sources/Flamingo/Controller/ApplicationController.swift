/**
  Main application controller every controller must conform to.
*/
public protocol ApplicationController {
  init()
}

// MARK: - Responses

public extension ApplicationController {

  /**
    Renders a view template using a renderer from the config.

    - Parameter template: The name of a template.
    - Parameter context: Context parameters to use in a template.
    - Returns: The response.
  */
  public func render(_ template: String, context: [String: Any] = [:]) -> Response {
    let body = Config.ViewRenderer.init(path: template, context: context).render()
    return Response(status: .ok, mime: .html, body: body)
  }

  /**
    Renders a JSON object.

    - Parameter json: JSON representable.
    - Returns: The response.
  */
  public func render(json: JSONRepresentable) -> Response {
    return Response(status: .ok, mime: .json, body: json.json)
  }

  /**
    Renders a JSON object.

    - Parameter data: Data representable.
    - Returns: The response.
  */
  public func render(data: DataRepresentable, mime: MimeType) -> Response {
    return Response(status: .ok, mime: mime, body: data)
  }

  public typealias MimeResponder = Dictionary<MimeType, () -> Response>

  /**
    Determines the desired response format from the HTTP Accept header
    and responds with first corresponding passed response if there is any.

    - Parameter request: The request.
    - Parameter responders: Dictionary with mime responders.

    - Returns: The response.
  */
  public func respond(to request: Request, _ responders: MimeResponder) -> Response {
    let accepts = request.headers["Accept"]?.split(separator: ",") ?? []

    return responders.filter({ accepts.contains($0.0.rawValue) }).first?.1()
      ?? Response(status: .notAcceptable)
  }

  /**
    Redirects to the given path

    - Parameter path: The path.
    - Returns: The response.
  */
  public func redirect(to path: String) -> Response {
    return Response(status: .found, headers: ["Location": path])
  }
}

/**
  Controller that is aware of adding new routes.
*/
public protocol RoutingController: ApplicationController {

  /**
    Method to register routes.

    - Parameter map: Route container.
  */
  func draw(map: RouteContainer)
}
