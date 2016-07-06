public class StencilBubble: Bubble {

  public static var scheme = BubbleScheme(name: "Stencil")
  public let container: Container

  /**
  */
  public required init(container: Container) {
    self.container = container
  }

  /**
  */
  public func mount(on kernel: Kernel) {
    if let config = container.resolve(Config.self) {
      container.register(TemplateEngine.self) {
        return StencilEngine(root: config.root)
      }
    }
  }
}
