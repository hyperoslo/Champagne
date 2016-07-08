public typealias MimeResponder = Dictionary<MimeType, () -> Response>

/**
  Factory that produces responses.
*/
public protocol RenderResponseFactory {

  /// Template prefix.
  var templatePrefix: String { get }

  /// Template engine.
  var templateEngine: TemplateEngine? { get }
}

public extension RenderResponseFactory {

  /**
    Renders a view template using a renderer from the config.

    - Parameter template: The name of a template.
    - Parameter context: Context parameters to use in a template.
    - Returns: The response.
  */
  func render(template: String, context: [String: Any] = [:]) -> Response {
    let name = templatePrefix.isEmpty
      ? template
      : "\(templatePrefix)/\(template)"

    guard let engine = templateEngine,
      body = try? engine.render(template: name, context: context)
      else { return Response(status: .notFound) }

    return Response(status: .ok, mime: .html, body: body)
  }

  /**
    Renders a JSON object.
    - Parameter json: JSON representable.
    - Returns: The response.
  */
  func render(json: JSONRepresentable) -> Response {
    return Response(status: .ok, mime: .json, body: json.json)
  }

  /**
    Renders a JSON object.
    - Parameter json: A dictionary.
    - Returns: The response.
  */
  func render(json: [String: Any]) -> Response {
    let json = try? JSON(json)
    return Response(status: .ok, mime: .json, body: json ?? JSON.null)
  }

  /**
    Determines the desired response format from the HTTP Accept header
    and responds with first corresponding passed response if there is any.

    - Parameter request: The request.
    - Parameter responders: Dictionary with mime responders.
    - Returns: The response.
  */
  func respond(to request: Request, _ responders: MimeResponder) -> Response {
    let accepts = request.headers["Accept"]?.split(separator: ",") ?? []

    return responders.filter({ accepts.contains($0.0.rawValue) }).first?.1()
      ?? Response(status: .notAcceptable)
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

  /**
    Redirects to the given path

    - Parameter path: The path.
    - Returns: The response.
  */
  func redirect(to path: String) -> Response {
    return Response(status: .found, headers: ["Location": path])
  }
}
