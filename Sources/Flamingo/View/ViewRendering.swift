/**
  A basic protocol for every view renderer.
*/
public protocol ViewRendering {
  /**
    Creates a new view renderer instance.

    - Parameter path: The template string loaded from the file.
    - Context: Values to fill into the template.
  */
  init(path: String, context: [String: Any])

  /**
    Renders a template string with a given context.

    - Returns: The rendered template with inserted context information.
  */
  func render() -> String
}
