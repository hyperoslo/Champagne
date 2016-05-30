/**
  Application configuration
*/
public struct Config {
  public static var viewsDirectory = "Views"
  public static var publicDirectory = "Public"

  public static var ViewRenderer: ViewRendering.Type = StencilRenderer.self
}
