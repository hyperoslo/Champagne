import Flamingo

Config.viewsDirectory = "Sources/Development/Views"

let controller = MainController()

Flamingo.application.router.draw { map in
  map.use(controller: MainController.self)
  map.resources("birds", only: [.index, .show], controller: BirdController.self)

  map.namespace("api") { map in
    map.resources("birds", only: [.index, .show], controller: BirdController.self)
    map.namespace("test", controller: MainController.self)
  }
}

try Flamingo.application.start()
