import Flamingo

class AppMod: Mod {

  static var scheme = ModScheme(name: "App", routePrefix: "")
  let container: Container

  required init(container: Container) {
    self.container = container
  }

  func draw(map: RouteCollection) {
    map.use {
      self.controller(MainController.self)
    }

    map.namespace("main") { map in
      map.use {
        self.controller(MainController.self)
      }
    }
  }
}
