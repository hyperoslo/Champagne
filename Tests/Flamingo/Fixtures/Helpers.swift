import PathKit
@testable import Flamingo

struct TestError: ErrorProtocol {}

struct Globals {

  static var root: String {
    return (Path(#file).parent() + "TestApp").description
  }

  static var config: Config {
    return Config(root: root)
  }

  static var kernel = AppKernel()

  static var application = Application(kernel: kernel, config: config)
}
