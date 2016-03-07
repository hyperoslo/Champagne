import PackageDescription

let package = Package(
  name: "Flamingo",
  targets: [
    Target(name: "Tests", dependencies: [.Target(name: "Flamingo")]),
  ],
  dependencies: [
  ]
)
