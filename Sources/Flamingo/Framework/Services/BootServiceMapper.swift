struct BootServiceMapper: ServiceMapper {

  /**
   Registers services in application container.

   - Parameter container: Application container.
  */
  func addServices(to container: Container) {
    if let config = container.resolve(Config.self) {
      container.register {
        return AssetProvider(config: config)
      }
    }
  }
}
