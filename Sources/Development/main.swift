import Flamingo

Config.viewsDirectory = "Sources/Development/Views"

let app = Application()
let controller = Controller()

app.router.draw { map in
  map.root(respond: controller.index)
  map.resources("users", controller: Controller.self)

  map.namespace("api") { map in
    map.fallback(respond: controller.index)
    map.root(respond: controller.index)
    map.resources("users", controller: Controller.self)
    map.get("log", respond: controller.index)
  }
}

try app.start()
