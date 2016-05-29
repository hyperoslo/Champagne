public protocol ApplicationController {
  init()
}

// MARK: - Rendering

public extension ApplicationController {

  public func render(_ template: String, context: [String: Any] = [:]) -> Response {
    let body = Config.ViewRenderer.init(path: template, context: context).render()
    return Response(status: .ok, contentType: .html, body: body)
  }
}
