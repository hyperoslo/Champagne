import PackageDescription

let package = Package(
  name: "Champagne",
  targets: [
    Target(
      name: "Demo",
      dependencies: [
        .Target(name: "Champagne")
      ]
    ),
    Target(
      name: "Champagne"
    ),
  ],
  dependencies: [
    // Standards
    .Package(url: "https://github.com/open-swift/S4.git", majorVersion: 0, minor: 9),
    // POSIX Regular expressions
    .Package(url: "https://github.com/vadymmarkov/Rexy.git", majorVersion: 0, minor: 5),
    // Server
    .Package(url: "https://github.com/VeniceX/TCP.git", majorVersion: 0, minor: 8),
    .Package(url: "https://github.com/Zewo/HTTPParser.git", majorVersion: 0, minor: 9),
    .Package(url: "https://github.com/Zewo/HTTPSerializer.git", majorVersion: 0, minor: 8),
    // JSON
    .Package(url: "https://github.com/czechboy0/Jay.git", majorVersion: 0, minor: 13),
    // Template engine
    .Package(url: "https://github.com/necolt/Stencil.git", versions: Version(0,5,6)..<Version(1,0,0)),
  ]
)
