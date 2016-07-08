/**
  Protocol for types initialized with `Container`.
*/
public protocol ContainerAware {

  /// Application container.
  var container: Container { get }

  /**
    Creates a new instance of `Self`

    - Parameter container: Application container
  */
  init(container: Container)
}
