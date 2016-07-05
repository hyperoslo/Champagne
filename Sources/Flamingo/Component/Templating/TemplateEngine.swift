/**
  A basic protocol for every template engine.
*/
public protocol TemplateEngine {
  /**
    Creates a new `Self` instance.

    - Parameter root: The root application path.
  */
  init(root: String)

  /**
    Renders a template string with a given context.
    - Parameter template: The template path.
    - Parameter context: Values to fill into the template.

    - Returns: The rendered template with inserted context information.
    - Throws: Rendering error.
  */
  func render(template: String, context: [String: Any]) throws -> String
}
