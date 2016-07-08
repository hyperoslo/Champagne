import Champagne

class CatalogBubble: Bubble {

  static var scheme = BubbleScheme(name: "Catalog", routePrefix: "catalog")
  let container: Container

  required init(container: Container) {
    self.container = container
  }

  func draw(map: RouteCollection) {
    map.resources("birds", only: [.index, .show]) {
      self.controller(BirdsController.self)
    }
  }
}
