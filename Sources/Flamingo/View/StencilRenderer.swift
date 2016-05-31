import Stencil
import String
import PathKit

/**
  View renderer based on Stencil template language.
*/
public struct StencilRenderer: ViewRendering {
  let path: Path
  let context: [String: Any]

  /**
    Creates a new view renderer instance.

    - Parameter path: The template string loaded from the file.
    - Context: Values to fill into the template.
  */
  public init(path: String, context: [String: Any] = [:]) {
    self.context = context
    self.path = Path(Config.viewsDirectory) + "\(path).html.stencil"
  }

  /**
    Renders a template string with a given context.
    
    - Returns: The rendered template with inserted context information.
  */
  public func render() -> String {
    do {
      return try Template(path: path).render(context: Context(dictionary: context))
    } catch {
      return "Failed to render template \(error)"
    }
  }
}
