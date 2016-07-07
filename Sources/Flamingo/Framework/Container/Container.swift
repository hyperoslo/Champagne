/**
  Service container.
*/
public class Container {

  /// Container key.
  struct Key {
    let type: Any.Type
    let tag: String?

    init(type: Any.Type, tag: String? = nil) {
      self.type = type
      self.tag = tag
    }
  }

  typealias Factory = () -> Any

  /// Dictionary of factories.
  private(set) var factories = [Key: Factory]()

  // MARK: - Register

  /**
    Registers an instance of the specified type, optionally with the given tag.

    - Parameter tag: Service tag (name).
    - Parameter factory: Factory that creates a new instance of the specified type.
  */
  public func register<T: Any>(tag: String? = nil, factory: () -> T) {
    let key = Key(type: T.self, tag: tag)
    factories[key] = { factory($0) }
  }

  /**
    Registers an instance of the specified type, optionally with the given tag.

    - Parameter serviceType: Service type.
    - Parameter tag: Service tag (name).
    - Parameter factory: Factory that creates a new instance of the specified type.
  */
  public func register<T: Any>(_ serviceType: T.Type, tag: String? = nil, factory: () -> T) {
    let key = Key(type: serviceType, tag: tag)
    factories[key] = { factory($0) }
  }

  // MARK: - Resolve

  /**
    Resolves an instance of the specified type.

    - Parameter serviceType: Service type to resplve.
    - Parameter tag: Service tag (name).

    - Returns: An instance of the specified type if found.
  */
  public func resolve<T: Any>(_ serviceType: T.Type, tag: String? = nil) -> T? {
    let key = Key(type: serviceType, tag: tag)
    return factories[key]?() as? T
  }
}

// MARK: - Hashable

extension Container.Key: Hashable {

  /// Hash value.
  var hashValue: Int {
    return String(type).hashValue ^ (tag?.hashValue ?? 0)
  }
}

// MARK: - Equatable

func ==(lhs: Container.Key, rhs: Container.Key) -> Bool {
  return lhs.type == rhs.type && lhs.tag == rhs.tag
}
