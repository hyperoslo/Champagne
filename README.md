![Champagne](https://github.com/hyperoslo/Champagne/blob/master/Resources/ChampagneCover.png)

The Champagne Web Framework.

[![CI Status](http://img.shields.io/travis/hyperoslo/Champagne.svg?style=flat)](https://travis-ci.org/hyperoslo/Champagne)
![Linux](https://img.shields.io/badge/os-linux-green.svg?style=flat)
![Mac OS X](https://img.shields.io/badge/os-Mac%20OS%20X-green.svg?style=flat)
![Swift](https://img.shields.io/badge/%20in-swift%203.0-orange.svg)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

**Champagne** is a Swift web framework with flexible and powerful modular
system.

* Conventional project structure.
* Modularity with `bubbles` - bundles/components that help to organize
the project code and spit functionality into separate feature-based modules.
* Application-specific `bubbles` used to build your application.
* Reusable `bubbles` that could be made into Swift packages and be shared across
many projects.
* Smart assets management.
* Template engines, resource and rendering factories.
* Built-in routing system.
* [S4](https://github.com/open-swift/S4) compatible [server](https://github.com/VeniceX/Venice).
* More features are coming...

**Please note** that this is a work in progress, `Champagne` is under continuous
development and **is not ready** for production usage.

* [Installation](#installation)
* [Usage](#usage)
* [Author](#author)
* [Credits](#credits)
* [Contributing](#contributing)
* [License](#license)

## Installation

* Install Swift development snapshot [version](https://github.com/hyperoslo/Champagne/blob/master/.swift-version)
from [Swift.org](https://swift.org/download/) or via [swiftenv](https://github.com/kylef/swiftenv).
* Add the following lines to your `Package.swift`:

## Usage

```swift
import Champagne

let kernel = AppKernel()

do {
  let application = Application(
    kernel: kernel,
    config: Config(root: "/")
  )

  try application.start()
} catch {
  print(error)
}
```

For more info about the project structure and conventions please check
[Demo](https://github.com/hyperoslo/Champagne/blob/master/Sources/Demo)

## Author

Hyper Interaktiv AS, ios@hyper.no

## Credits

- Initial implementation is heavily inspired by [Vapor](https://github.com/qutheory/vapor)
which is the first true web framework for Swift.
- It's also worth mentioning that a lot of ideas came from
[Symfony](http://symfony.com), [Rails](https://github.com/rails/rails) and
other Ruby and PHP frameworks.
- And we salute the whole Swift server-side community, especially
[Zewo](https://github.com/Zewo/Zewo) and [OpenSwift](https://github.com/open-swift).
Thanks you for doing such an awesome job bringing developers open source
libraries and tools for all the needs.

## Contributing

We would love you to contribute to **Champagne**, check the [CONTRIBUTING](https://github.com/hyperoslo/Champagne/blob/master/CONTRIBUTING.md)
file for more info.

## License

**Champagne** is available under the MIT license. See the [LICENSE](https://github.com/hyperoslo/Champagne/blob/master/LICENSE.md) file for more info.
