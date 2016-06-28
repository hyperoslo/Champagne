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
  public func render(template: String, context: [String: Any] = [:]) -> Response {
    let body = Config.ViewRenderer.init(path: template, context: context).render()
    return Response(status: .ok, mime: .html, body: body)
  }

  /**
    Renders a view template using a renderer from the config.
    Template path is built automatically using conventions.

    For example:

    Controller:         `UsersController.swift`
    Response function:  `index(request:)`
    Template name:      `{Config.viewsDirectory}/Users/index.html`

    - Parameter context: Context parameters to use in a template.
    - Parameter file: File path, #file by default.
    - Parameter action: Function name, #function by default.

    - Returns: The response.
  */
  public func render(context: [String: Any] = [:], file: String = #file, action: String = #function) -> Response {
    guard let controller = file.split(separator: "/").last,
      name = action.split(separator: "(").first
      else { return Response(status: .notFound)  }

    var folder = controller
    folder.replace(string: "Controller.swift", with: "")

    return render(template: "\(folder)/\(name)", context: context)
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

    - Parameter json: A dictionary.
    - Returns: The response.
  */
  public func render(json: [String: Any]) -> Response {
    let json = try? JSON(json)
    return Response(status: .ok, mime: .json, body: json ?? JSON.null)
  }

  /**
    Renders a JSON object.

    - Parameter data: Data representable.
    - Parameter mime: Mime type.

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
