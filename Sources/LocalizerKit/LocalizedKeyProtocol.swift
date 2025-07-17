import Foundation

/// A generic protocol that allows developers to define their own enum
/// for localization keys used in the `LocalizedLanguage` system.
/// 
/// Conforming types must be enums backed by a `String` raw value
/// and conform to `Hashable` so they can be used as dictionary keys.
public protocol LocalizedKeyProtocol: RawRepresentable<String>, Hashable {}