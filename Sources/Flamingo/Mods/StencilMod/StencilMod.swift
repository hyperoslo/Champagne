public class StencilMod: Mod {

  public static var scheme = ModScheme(name: "Stencil")
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
