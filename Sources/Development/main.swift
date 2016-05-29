import Flamingo

Config.viewsDirectory = "Sources/Demo/Views"

let app = Application()

app.route { route in
  let controller = Controller()

  route.resources(name: "resource", controller: controller)
  route.get("/", respond: controller.index)
}

try app.start()
