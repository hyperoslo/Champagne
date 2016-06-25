import PackageDescription

let package = Package(
  name: "Flamingo",
  targets: [
    Target(
      name: "Development",
      dependencies: [
        .Target(name: "Flamingo")
      ]
    ),
    Target(
      name: "Flamingo",
      dependencies: [
        .Target(name: "libc")
      ]
    ),
  ],
  dependencies: [
    .Package(url: "https://github.com/open-swift/S4.git", majorVersion: 0, minor: 9),
    .Package(url: "https://github.com/vadymmarkov/Rexy.git", majorVersion: 0, minor: 5),
    .Package(url: "https://github.com/necolt/Stencil.git", versions: Version(0,5,6)..<Version(1,0,0)),
    .Package(url: "https://github.com/VeniceX/HTTPServer.git", versions: Version(0,5,0)..<Version(1,0,0))
  ]
)
