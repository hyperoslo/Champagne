import Flamingo

class AppKernel: Kernel {

  static var scheme = KernelScheme(name: "App")

  var mods: [Mod.Type] {
    return [
      AppMod.self,
      BirdMod.self
    ]
  }
}
