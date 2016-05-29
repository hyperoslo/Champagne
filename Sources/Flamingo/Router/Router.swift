import Foundation
import S4
@_exported import Router
import PathKit

extension Router {

    public static func create(build: (route: RouterBuilder) -> Void) -> Router {
        return self.init(middleware: ParametersMiddleware(), CookiesMiddleware()) { route in
            route.fallback { request in
                if let staticFile = serveStaticFile(request: request) {
                    return staticFile
                } else {
                    return Response(status: .notFound, body: "Route Not Found")
                }
            }

            build(route: route)
        }
    }

    static func serveStaticFile(request: Request) -> Response? {
        guard request.uri.path != "/" else { return nil }

        let publicPath = Path(Config.publicDirectory)
        guard publicPath.exists && publicPath.isDirectory else { return nil }

        let filePath = publicPath + String(request.uri.path!.characters.dropFirst())
        guard filePath.exists else { return nil }

        guard filePath.isReadable else {
            return Response(status: .notFound, body: "Can't Open File. Permission Denied")
        }

        do {
            let contents = try filePath.read()
            if let body = String(data: contents, encoding: NSUTF8StringEncoding) {
                return Response(status: .ok, body: body)
            }
        } catch {
            return Response(status: .notFound, body: "Error Reading From File")
        }

        return nil
    }

}

extension RouterBuilder {

  public func resources(name: String, middleware: Middleware..., controller: ResourceController) {
    get(name, respond: controller.index)
    get(name + "/new", respond: controller.new)
    get(name + "/:id", respond: controller.show)
    get(name + "/:id/edit", respond: controller.edit)
    post(name, respond: controller.create)
    delete(name + "/:id", respond: controller.destroy)
    patch(name + "/:id", respond: controller.update)
  }
}
