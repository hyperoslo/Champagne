import Foundation

/**
  Champagne application.
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

  /// Application bubbles.
  public var bubbles = [Bubble]()

  /// Application router.
  let router: Router

  /// Flag that indicates if server is running.
  var running = false

  /**
    Creates a new instance of `Application`.

    - Parameter kernel: Application kernel.
    - Parameter config: Application config.
  */
  public init(kernel: Kernel, config: Config = Config()) {
    self.kernel = kernel
    self.config = config

    // Setup config
    let bubbleTypes = kernel.frameworkBubbles + kernel.bubbles

    config.kernelScheme = kernel.dynamicType.scheme
    config.bubbleSchemes = bubbleTypes.map({ $0.scheme })

    // Configure container
    container = Container()

    container.register { config }

    for serviceMapper in kernel.serviceMappers {
      serviceMapper.addServices(to: container)
    }

    // Boot kernel
    kernel.addServices(to: container)
    var middleware = kernel.frameworkMiddleware
    middleware.append(contentsOf: kernel.middleware)

    // Mount bubbles
    let routeCollection = RouteCollection()

    for bubbleType in bubbleTypes {
      let bubble = bubbleType.init(container: container)

      middleware.append(contentsOf: bubble.middleware)
      bubble.mount(on: kernel)
      routeCollection.namespace(bubbleType.scheme.routePrefix, build: bubble.draw)

      bubbles.append(bubble)
    }

    let fallback: Responder

    if let responder = container.resolve(Responder.self, tag: "fallback") {
      fallback = responder
    } else {
      fallback = FallbackResponder(container: container)
    }

    router = Router(
      collection: routeCollection,
      fallback: fallback,
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
