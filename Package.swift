import PackageDescription

let package = Package(
  name: "Flamingo",
  targets: [
    Target(name: "Tests", dependencies: [.Target(name: "Flamingo")]),
  ],
  dependencies: [
    .Package(url: "https://github.com/nestproject/Inquiline.git", majorVersion: 0),
    .Package(url: "https://github.com/kylef/URITemplate.swift", majorVersion: 2),
    .Package(url: "https://github.com/kylef/spectre-build.git", majorVersion: 0),
  ]
)
