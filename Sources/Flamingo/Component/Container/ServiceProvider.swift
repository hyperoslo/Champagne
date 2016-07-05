/**
  Protocol for types that are aware of services binding.
*/
public protocol ServiceProvider {

  /**
   Registers services on application container.

   - Parameter container: Application container.
   - Throws: Container error.
  */
  func registerServices(on container: Container) throws
}
