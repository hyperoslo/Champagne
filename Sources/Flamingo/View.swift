import Stencil
import PathKit

public protocol ViewRendering {
    init(path: String, context: [String: Any]?)
    func render() -> String
}

public struct StencilRenderer: ViewRendering {
    var template: Template?
    var context: [String: Any]?

    public init(path: String, context: [String: Any]?) {
        let defaultTemplateLoader = TemplateLoader(paths: [Path(Config.viewsDirectory)])
        if context != nil {
            self.context = context
            self.context!["loader"] = defaultTemplateLoader
        } else {
            self.context = ["loader": defaultTemplateLoader]
        }

        var templatePath = path.characters.split {$0 == "/"}.map(String.init)
        let templateName = templatePath.removeLast()

        let appPath = Path(Config.viewsDirectory)
        let paths = [appPath + templatePath.joined(separator: "/")]
        let templateLoader = TemplateLoader(paths: paths)
        self.template = templateLoader.loadTemplate(name: templateName + ".html.stencil")
    }

    public func render() -> String {
        guard template != nil else { return "Template Not Found" }
        guard context != nil else { return try! template!.render() }
        return try! template!.render(context: Context(dictionary: context!))
    }
}
