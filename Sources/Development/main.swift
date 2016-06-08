import Flamingo

Config.viewsDirectory = "Sources/Development/Views"

let controller = MainController()

Flamingo.application.router.draw { map in
  map.use(controller: MainController.self)
  map.resources("users", controller: BirdController.self)

  map.namespace("api") { map in
    map.resources("users", controller: BirdController.self)
  }
}

try Flamingo.application.start()
