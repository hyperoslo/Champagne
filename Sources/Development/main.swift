import Flamingo

Config.viewsDirectory = "Sources/Development/Views"

let app = Application()
let controller = Controller()

app.draw { map in
  map.root(respond: controller.index)
  map.resources("users", controller: controller)

  map.compose("api") { map in
    map.root(respond: controller.index)
    map.resources("/users", controller: controller)
    map.get("/log", respond: controller.index)
  }
}

try app.start()
