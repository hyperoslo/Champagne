import PathKit
@testable import Champagne

struct TestError: ErrorProtocol {}

struct Globals {

  static var root: String {
    return (Path(#file).parent().parent() + "TestApp").description
  }

  static var application: Application {
    return Application(kernel: AppKernel(), config: Config(root: Globals.root))
  }

  static func application(config: Config) -> Application {
    return Application(kernel: AppKernel(), config: config)
  }
}
