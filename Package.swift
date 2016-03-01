import PackageDescription

let package = Package(
  name: "Flamingo",
  targets: [
    Target(name: "Tests", dependencies: [.Target(name: "Flamingo")]),
  ],
  dependencies: [
    .Package(url: "https://github.com/nestproject/Inquiline.git", majorVersion: 0),
  ]
)
