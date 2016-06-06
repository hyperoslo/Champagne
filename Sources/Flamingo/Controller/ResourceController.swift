/**
  Controller with a set of standard CRUD methods.
*/
public protocol ResourceController: ApplicationController {

  /**
    `GET /items`
    Displays a list of all resource items.

    - Parameter request: The request.
    - Returns: The response.
  */
  func index(request: Request) throws -> Response

  /**
    `GET /items/:id`
    Displays a specific resource item.

    - Parameter request: The request.
    - Returns: The response.
  */
  func show(request: Request) throws -> Response

  /**
    `GET /items/new.`
    Returns a form for creating a new resource item.

    - Parameter request: The request.
    - Returns: The response.
  */
  func new(request: Request) throws -> Response

  /**
    `POST /items.`
    Creates a new resource item.

    - Parameter request: The request.
    - Returns: The response.
  */
  func create(request: Request) throws -> Response

  /**
    `GET /items/:id/edit`
    Returns a form for editing a resource item.

    - Parameter request: The request.
    - Returns: The response.
  */
  func edit(request: Request) throws -> Response

  /**
    `PATCH /items/:id`
    Updates a specific resource item.

    - Parameter request: The request.
    - Returns: The response.
  */
  func update(request: Request) throws -> Response

  /**
    `DELETE /items/:id`
    Deletes a specific resource item.

    - Parameter request: The request.
    - Returns: The response.
  */
  func destroy(request: Request) throws -> Response
}
