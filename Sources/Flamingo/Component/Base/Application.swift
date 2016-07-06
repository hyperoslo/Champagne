import Foundation

/**
  Flamingo application.
*/
public class Application {

  /// Current application version.
  public static let version = "0.3.0"

  /// Application container.
  let container: Container

  /// Application container.
  let config: Config

  /// Application kernel.
  public let kernel: Kernel

  /// Application mods.
  public var mods = [Mod]()

  /// Application router.
  let router: Router

  /// Flag that indicates if server is running.
  var running = false

  // Application middleware.
  var middleware: [Middleware] = [
    ParametersMiddleware(),
    ErrorMiddleware()
  ]

  /// Service providers
  var serviceProviders: [ServiceProvider] = [
    BootServicePorvider()
  ]

  /**
    Creates a new instance of `Application`.

    - Parameter kernel: Application kernel.
    - Parameter config: Application config.

    - Throws: Initialization error.
  */
  public init(kernel: Kernel, config: Config = Config()) throws {
    self.kernel = kernel
    self.config = config

    // Setup config
    let modTypes = kernel.frameworkMods + kernel.mods

    config.kernelScheme = kernel.dynamicType.scheme
    config.modSchemes = modTypes.map({ $0.scheme })

    // Configure container
    container = Container()

    container.register { config }

    for serviceProvider in serviceProviders {
      try serviceProvider.registerServices(on: container)
    }

    // Boot kernel
    try kernel.registerServices(on: container)
    middleware.append(contentsOf: kernel.middleware)

    // Mount mods
    let routeCollection = RouteCollection()

    for modType in modTypes {
      let mod = modType.init(container: container)

      middleware.append(contentsOf: mod.middleware)
      mod.mount(on: kernel)
      routeCollection.namespace(modType.scheme.routePrefix, build: mod.draw)

      mods.append(mod)
    }

    router = Router(
      collection: routeCollection,
      container: container,
      middleware: middleware
    )
  }

  // MARK: - Server

  /**
    Starts HTTP server with the router as a responder.
    - Throws: ErrorType.
  */
  public func start() throws {
    print(Art.header)
    try config.server.init(host: "0.0.0.0", port: 8080, responder: router).start()
    running = true
  }
}
