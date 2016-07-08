/**
  Protocol for types that are aware of services binding.
*/
public protocol ServiceMapper {

  /**
   Registers services in application container.

   - Parameter container: Application container.
  */
  func addServices(to container: Container)
}
