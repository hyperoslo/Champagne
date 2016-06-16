#if os(Linux)
    import Glibc
#else
    import Foundation
#endif

/**
  Utility to interact with environment variables.
*/
public struct Env {

  /**
    Returns a value for the given key.

    - Parameter key: The key.

    - Returns: Optional value if env var is found.
  */
  public static func value(_ key: String) -> String? {
    guard let value = getenv(key), string = String(validatingUTF8: value) else {
      return nil
    }

    return string
  }

  /**
    Sets a new value for a given environment variable.

    - Parameter key: The key.
    - Parameter value: The value.
  */
  public static func add(value: String, key: String) {
    setenv(key, value, 1)
  }

  /**
    Removes an environment variable.

    - Parameter key: The key.
  */
  public static func remove(_ key: String) {
    unsetenv(key)
  }

  /**
    Checks if environment variable with a given key exists.

    - Parameter key: key.

    - Returns: True if env var is set or false otherwise.
  */
  public static func contains(_ key: String) -> Bool {
    return value(key) != nil
  }
}
