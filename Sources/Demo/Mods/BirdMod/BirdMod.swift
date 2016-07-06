import Flamingo

class BirdMod: Mod {

  static var scheme = ModScheme(name: "Bird", routePrefix: "birds")
  let container: Container

  required init(container: Container) {
    self.container = container
  }

  func draw(map: RouteCollection) {
    map.resources("catalog", only: [.index, .show]) {
      self.controller(BirdController.self)
    }
  }
}
