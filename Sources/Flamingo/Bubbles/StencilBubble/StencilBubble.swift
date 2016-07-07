/**
  Stencil template engine provider.
*/
public class StencilBubble: Bubble {

  /// Bubble scheme.
  public static var scheme = BubbleScheme(name: "Stencil")

  /// Application container.
  public let container: Container

  /**
    Creates a new instance of `StencilBubble`

    - Parameter container: Application container.
  */
  public required init(container: Container) {
    self.container = container
  }

  /**
    Registers sevices in the application container.

    - Parameter kernel: Application kernel.
  */
  public func mount(on kernel: Kernel) {
    if let config = container.resolve(Config.self) {
      container.register(TemplateEngine.self) {
        return StencilEngine(root: config.root)
      }
    }
  }
}
