/**
  Main controller protocol every controller must conform to.
*/
public class Controller: RenderResponseFactory {

  public let bubbleScheme: BubbleScheme

  /// Application container.
  public let container: Container

  /// Controller template prefix.
  public var templatePrefix: String

  /// Template engine.
  public let templateEngine: TemplateEngine?

  // MARK: - Initialization

  /**
    Creates a new instance of `Controller`.

    - Parameter bubbleScheme: Bubble configuration.
    - Parameter container: Application container.
  */
  public required init(bubbleScheme: BubbleScheme, container: Container) {
    self.bubbleScheme = bubbleScheme
    self.container = container
    self.templatePrefix = bubbleScheme.dir.views
    self.templateEngine = container.resolve(TemplateEngine.self)
  }

  // MARK: - Responses

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
  public func render(context: [String: Any] = [:],
                        file: String = #file,
                      action: String = #function) -> Response {
    guard let controller = file.split(separator: "/").last,
      name = action.split(separator: "(").first
      else { return Response(status: .notFound) }

    var folder = controller
    folder.replace(string: "Controller.swift", with: "")

    return render(template: "\(folder)/\(name)", context: context)
  }
}
