import Stencil
import String
import PathKit

public protocol ViewRendering {
  init(path: String, context: [String: Any])
  func render() -> String
}

public struct StencilRenderer: ViewRendering {
  let path: Path
  let context: [String: Any]

  public init(path: String, context: [String: Any] = [:]) {
    self.context = context
    self.path = Path(Config.viewsDirectory) + "\(path).html.stencil"
  }

  public func render() -> String {
    do {
      return try Template(path: path).render(context: Context(dictionary: context))
    } catch {
      return "Failed to render template \(error)"
    }
  }
}
