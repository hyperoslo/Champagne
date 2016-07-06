import Flamingo

class AppKernel: Kernel {

  static var scheme = KernelScheme(name: "App")

  var bubbles: [Bubble.Type] {
    return [
      AppBubble.self,
      CatalogBubble.self
    ]
  }
}
