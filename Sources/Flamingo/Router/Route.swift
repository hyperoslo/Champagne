public struct Route {

  public typealias Action = (Request) throws -> Response

  let path: String
  let method: Request.Method
  let action: Action
}
