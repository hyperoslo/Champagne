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
  public static func get(_ key: String) -> String? {
    guard let string = String(validatingUTF8: getenv(key)) else {
      return nil
    }

    return string
  }

  /**
    Sets a new value for a given environment variable.

    - Parameter key: The key.
    - Parameter value: The value.
  */
  public static func set(key: String, value: String) {
    setenv(key, value, 1)
  }

  /**
    Removes an environment variable.

    - Parameter key: The key.
  */
  public static func unset(_ key: String) {
    unsetenv(key)
  }

  /**
    Checks if environment variable with a given key exists.

    - Parameter key: key.

    - Returns: True if env var is set or false otherwise.
  */
  public static func hasKey(_ key: String) -> Bool {
    return get(key) != nil
  }
}
