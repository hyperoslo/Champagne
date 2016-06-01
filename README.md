# Flamingo

A Web Framework for Swift that works on Linux and OS X.

[![CI Status](http://img.shields.io/travis/hyperoslo/Flamingo.svg?style=flat)](https://travis-ci.org/hyperoslo/Flamingo)
[![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
[![Mac OS X](https://img.shields.io/badge/os-Mac%20OS%20X-green.svg?style=flat)
[![Swift](https://img.shields.io/badge/%20in-swift%203.0-orange.svg)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
[![Codebeat](https://codebeat.co/badges/10ee7f48-79d2-4782-8366-b261568a4e41)](https://codebeat.co/projects/github-com-hyperoslo-flamingo)

## Usage

```swift
import Flamingo

let controller = MainController()

Flamingo.application.router.draw { map in
  map.root(respond: controller.index)
  map.get("about", respond: controller.about)

  map.namespace("api") { map in
    map.resources("users", controller: UsersController.self)
  }
}

try Flamingo.application.start()
```

Generated routes are:

```http
GET /
GET /about
GET /api/users
GET /api/users/new
GET /api/users/:id
GET /api/users/:id/edit
POST /api/users
DELETE /api/users/:id
PATCH /api/users/:id
```

## Building

`Swift 3.0` is needed to build the package and run the application server.

- Install the latest version of `Swift` using [swiftenv](https://github.com/kylef/swiftenv)
- If you want to install `Swift` manually, visit [Swift.org](https://swift.org)
to learn more about installing development [snapshots](https://swift.org/download/#snapshots) on your system.

## Installation

`Flamingo` is available through [Swift Package Manager](https://github.com/apple/swift-package-manager).
To install it, simply add the following lines to your `Package.swift`:

```swift
import PackageDescription

let package = Package(
    name: "FlamingoApplication",
    dependencies: [
      .Package(url: "https://github.com/hyperoslo/Flamingo.git", versions: Version(0,1,0)..<Version(1,0,0))
    ]
)
```

## 🚸 Work in Progress

`Flamingo` is under continuous development and **is not ready** for production usage.

## Author

Hyper Interaktiv AS, ios@hyper.no

## Contributing

We would love you to contribute to Cache, check the [CONTRIBUTING](https://github.com/hyperoslo/Flamingo/blob/master/CONTRIBUTING.md)
file for more info.

## License

**Flamingo** is available under the MIT license. See the [LICENSE](https://github.com/hyperoslo/Flamingo/blob/master/LICENSE.md) file for more info.
