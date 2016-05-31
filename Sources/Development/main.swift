import Flamingo

Config.viewsDirectory = "Sources/Development/Views"

let controller = Controller()

Flamingo.application.router.draw { map in
  map.root(respond: controller.index)
  map.resources("users", controller: Controller.self)

  map.namespace("api") { map in
    map.fallback(respond: controller.index)
    map.root(respond: controller.index)
    map.resources("users", controller: Controller.self)
    map.get("log", respond: controller.index)
  }
}

try Flamingo.application.start()
