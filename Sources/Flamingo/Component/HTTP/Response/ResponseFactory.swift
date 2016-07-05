public typealias MimeResponder = Dictionary<MimeType, () -> Response>

/**
  Factory that produces responses.
*/
public protocol ResponseFactory {

  /// Template prefix.
  var templatePrefix: String { get }

  /// Template engine.
  var templateEngine: TemplateEngine? { get }
}

public extension ResponseFactory {

  func render(template: String, context: [String: Any] = [:]) -> Response {
    let name = templatePrefix.isEmpty
      ? template
      : "\(templatePrefix)/\(template)"

    guard let engine = templateEngine,
      body = try? engine.render(template: name, context: context)
      else { return Response(status: .notFound) }

    return Response(status: .ok, mime: .html, body: body)
  }

  func render(json: JSONRepresentable) -> Response {
    return Response(status: .ok, mime: .json, body: json.json)
  }

  func render(json: [String: Any]) -> Response {
    let json = try? JSON(json)
    return Response(status: .ok, mime: .json, body: json ?? JSON.null)
  }

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

  func redirect(to path: String) -> Response {
    return Response(status: .found, headers: ["Location": path])
  }
}
