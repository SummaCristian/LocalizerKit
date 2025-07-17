import Foundation


/// A protocol that defines the structure of a localized strings collection.
/// 
/// Each language must provide a struct conforming to this protocol,
/// which supplies a static set of localized strings mapped to keys.
/// 
/// Although the `Key` type can vary between languages, it's **strongly recommended**
/// to use the same enum for every language to ensure consistency across translations.
public protocol LocalizedLanguage {
    /// The enum representing the set of localization keys for this language.
    /// 
    /// This must be `RawRepresentable` with a `String` raw value,
    /// and conform to `Hashable` for use as dictionary keys.
    associatedtype Key: RawRepresentable<String> & Hashable
    
    /// The `SupportedLanguage` this localization corresponds to.
    static var language: SupportedLanguage { get }
    
    /// The dictionary of localized strings, mapped from the associated `Key` enum.
    static var strings: [Key: String] { get }
}