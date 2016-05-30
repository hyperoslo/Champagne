/**
 Controller where the each method is a request to perform
 an operation on the resource.
 */
public protocol ResourceController: ApplicationController {

  /**
    Generates a route to display a list of all resource items.
    Corresponds to GET /items.
    - Parameter request: The request
    - Returns: The response
  */
  func index(request: Request) throws -> Response

  /**
    Displays a specific resource item.
    Corresponds to GET /items/:id.
    - Parameter request: The request
    - Returns: The response
  */
  func show(request: Request) throws -> Response

  /**
    Returns a form for creating a new resource item.
    Corresponds to GET /items/new.
    - Parameter request: The request
    - Returns: The response
  */
  func new(request: Request) throws -> Response

  /**
    Creates a new resource item.
    Corresponds to POST /items.
    - Parameter request: The request
    - Returns: The response
  */
  func create(request: Request) throws -> Response

  /**
    Returns a form for editing a resource item.
    Corresponds to POST /items/:id/edit.
    - Parameter request: The request
    - Returns: The response
  */
  func edit(request: Request) throws -> Response

  /**
    Updates a specific resource item.
    Corresponds to POST /items/:id.
    - Parameter request: The request
    - Returns: The response
  */
  func update(request: Request) throws -> Response

  /**
    Deletes a specific resource item.
    Corresponds to POST /items/:id.
    - Parameter request: The request
    - Returns: The response
  */
  func destroy(request: Request) throws -> Response
}
