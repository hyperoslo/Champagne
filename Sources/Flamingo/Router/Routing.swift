public protocol Routing {
  func resources(name: String, controller: ResourceController)
  func get(path: String, _ action: Route.Action)
  func post(path: String, _ action: Route.Action)
  func put(path: String, _ action: Route.Action)
  func patch(path: String, _ action: Route.Action)
  func delete(path: String, _ action: Route.Action)
  func head(path: String, _ action: Route.Action)
  func options(path: String, _ action: Route.Action)
}
