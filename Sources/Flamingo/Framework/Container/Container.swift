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

  // MARK: - Resolve

  public func resolve<T: Any>(_ serviceType: T.Type, tag: String? = nil) -> T? {
    let key = Key(type: serviceType, tag: tag)
    return factories[key]?() as? T
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
