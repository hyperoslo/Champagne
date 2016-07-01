# Flamingo

The Flamingo Web Framework.

[![CI Status](http://img.shields.io/travis/hyperoslo/Flamingo.svg?style=flat)](https://travis-ci.org/hyperoslo/Flamingo)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![Mac OS X](https://img.shields.io/badge/os-Mac%20OS%20X-green.svg?style=flat)
![Swift](https://img.shields.io/badge/%20in-swift%203.0-orange.svg)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)
[![Codebeat](https://codebeat.co/badges/10ee7f48-79d2-4782-8366-b261568a4e41)](https://codebeat.co/projects/github-com-hyperoslo-flamingo)

* [Getting started](#getting-started)
* [Usage](#usage)
* [Author](#author)
* [Credits](#credits)
* [Contributing](#contributing)
* [License](#license)

## Getting started

**Please note** that this is a work in progress, `Flamingo` is under continuous
development and **is not ready** for production usage.

`Flamingo` is available through [Swift Package Manager](https://github.com/apple/swift-package-manager).
To install it, simply add the following lines to your `Package.swift`:

```swift
.Package(url: "https://github.com/hyperoslo/Flamingo.git", versions: Version(0,1,0)..<Version(1,0,0))
```

`Swift 3.0` is needed to build the package and run the application server.
Install Development snapshot [version](https://github.com/hyperoslo/Flamingo/blob/master/.swift-version)
from [Swift.org](https://swift.org/download/) or via [swiftenv](https://github.com/kylef/swiftenv).

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

## Author

Hyper Interaktiv AS, ios@hyper.no

## Credits

- The current implementation is heavily inspired by [Vapor](https://github.com/qutheory/vapor)
which is the first true web framework for Swift.
- It's also worth mentioning that
a lot of ideas came from [Rails](https://github.com/rails/rails) and
other Ruby and PHP frameworks.
- And we salute the whole Swift server-side community, especially
[Zewo](https://github.com/Zewo/Zewo) and [OpenSwift](https://github.com/open-swift).
Thanks you for doing such an awesome job bringing developers open source
libraries and tools for all the needs.

## Contributing

We would love you to contribute to **Flamingo**, check the [CONTRIBUTING](https://github.com/hyperoslo/Flamingo/blob/master/CONTRIBUTING.md)
file for more info.

## License

**Flamingo** is available under the MIT license. See the [LICENSE](https://github.com/hyperoslo/Flamingo/blob/master/LICENSE.md) file for more info.
