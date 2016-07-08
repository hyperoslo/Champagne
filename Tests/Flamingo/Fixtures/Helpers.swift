import PathKit
@testable import Flamingo

struct TestError: ErrorProtocol {}

struct Globals {

  static var root: String {
    return (Path(#file).parent() + "TestApp").description
  }

  static var application: Application {
    return Application(kernel: AppKernel(), config: Config(root: Globals.root))
  }
}
