/**
  Type that is aware of adding new routes.
*/
public protocol RouteMapper {

  /**
    Registers new routes.

    - Parameter map: Route collection.
  */
  func draw(map: RouteCollection)
}
