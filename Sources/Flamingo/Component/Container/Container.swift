/**
  Service container.
*/
public class Container {

  enum Error: ErrorProtocol {
    case InvalidRegisteredType
  }

  struct Key {
    let type: Any.Type
    let tag: String?

    init(type: Any.Type, tag: String? = nil) {
      self.type = type
      self.tag = tag
    }
  }

  typealias Factory = () -> Any

  private(set) var types = [Key: Any.Type]()
  private(set) var factories = [Key: Factory]()

  // MARK: - Register

  public func register<T: Any>(tag: String? = nil, factory: () -> T) {
    let key = Key(type: T.self, tag: tag)
    factories[key] = { factory($0) }
  }

  public func register<T: Any>(_ serviceType: T.Type, tag: String? = nil, factory: () -> T) {
    let key = Key(type: serviceType, tag: tag)
    factories[key] = { factory($0) }
  }

  public func register<T: Any, U: Any>(_ serviceType: T.Type, tag: String? = nil, with targetType: U.Type) throws {
    guard let _ = targetType as? T.Type else { throw Error.InvalidRegisteredType }

    let key = Key(type: serviceType, tag: tag)
    types[key] = targetType
  }

  // MARK: - Resolve

  public func resolve<T: Any>(_ serviceType: T.Type, tag: String? = nil) -> T? {
    let key = Key(type: serviceType, tag: tag)
    return factories[key]?() as? T
  }

  public func resolve<T: Any>(typeOf serviceType: T.Type, tag: String? = nil) -> T.Type? {
    let key = Key(type: serviceType, tag: tag)
    return types[key] as? T.Type
  }
}

// MARK: - Hashable

extension Container.Key: Hashable {

  var hashValue: Int {
    return String(type).hashValue ^ (tag?.hashValue ?? 0)
  }
}

// MARK: - Equatable

func ==(lhs: Container.Key, rhs: Container.Key) -> Bool {
  return lhs.type == rhs.type && lhs.tag == rhs.tag
}
