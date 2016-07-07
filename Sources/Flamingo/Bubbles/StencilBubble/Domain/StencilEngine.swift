import Stencil
import String
import PathKit

/**
  Template engine based on Stencil template language.
*/
public struct StencilEngine: TemplateEngine {

  /// Root path.
  public let root: String

  /**
    Creates a new view renderer instance.
  */
  public init(root: String) {
    self.root = root
  }

  /**
    Renders a template string with a given context.

    - Parameter template: The template path.
    - Parameter context: Values to fill into the template.

    - Returns: The rendered template with inserted context information.
    - Throws: Rendering error.
  */
  public func render(template: String, context: [String: Any] = [:]) throws -> String {
    let path = Path(root + "/\(template).html.stencil")
    return try Template(path: path).render(context: Context(dictionary: context))
  }
}
