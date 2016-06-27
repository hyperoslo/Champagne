/**
  Main application controller every controller must conform to.
*/
public protocol ApplicationController {
  init()
}

// MARK: - Rendering

public extension ApplicationController {

  /**
    Renders a view template using a renderer from the config.

    - Parameter template: The name of a template.
    - Parameter context: Context parameters to use in a template.
    - Returns: A response.
  */
  public func render(_ template: String, context: [String: Any] = [:]) -> Response {
    let body = Config.ViewRenderer.init(path: template, context: context).render()
    return Response(status: .ok, mime: .html, body: body)
  }

  /**
    Renders a JSON object.

    - Parameter json: JSON representable.
    - Returns: A response.
  */
  public func render(json: JSONRepresentable) -> Response {
    return Response(status: .ok, mime: .json, body: json.json)
  }

  /**
    Renders a JSON object.

    - Parameter data: Data representable.
    - Returns: A response.
  */
  public func render(data: DataRepresentable, mime: MimeType) -> Response {
    return Response(status: .ok, mime: mime, body: data)
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
