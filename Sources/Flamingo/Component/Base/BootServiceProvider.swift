struct BootServicePorvider: ServiceProvider {

  /**
   Registers services on application container.

   - Parameter container: Application container.
   - Throws: Container error.
  */
  func registerServices(on container: Container) throws {
    if let config = container.resolve(Config.self) {
      container.register {
        return AssetProvider(config: config)
      }
    }
  }
}
