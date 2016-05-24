import PackageDescription

let package = Package(
  name: "Flamingo",
  targets: [
    Target(name: "Tests", dependencies: [.Target(name: "Flamingo")]),
  ],
  dependencies: [
    //Standards package. Contains protocols for cross-project compatability.
    .Package(url: "https://github.com/open-swift/S4.git", majorVersion: 0, minor: 6),
  ]
)
