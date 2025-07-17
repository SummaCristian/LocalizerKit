import Foundation

/// A static registry that stores all registered localization bundles,
/// mapping supported languages to their respective localized string dictionaries.
///
/// The `LocalizerRegistry` acts as a central cache of all registered localizations.
/// Each language is associated with a `[String: String]` dictionary that maps
/// raw string keys to localized values.
public struct LocalizerRegistry {
    
    /// Internal storage of localization bundles.
    ///
    /// Each `SupportedLanguage` maps to a dictionary of localized strings,
    /// where keys are raw string values from the language's `Key` enum.
    private static var bundles: [SupportedLanguage: [String: String]] = [:]
    
    /// Registers a localization bundle for a given language type.
    ///
    /// This function should be called once for each language during app startup,
    /// typically via the `.localized(in:)` view modifier.
    ///
    /// The localization struct must conform to `LocalizedLanguage`, and its
    /// key-value pairs will be stored under the specified `SupportedLanguage`.
    ///
    /// - Parameter type: A struct conforming to `LocalizedLanguage`.
    public static func register<T: LocalizedLanguage>(_ type: T.Type) {
        let mapped = type.strings.reduce(into: [String: String]()) { dict, entry in
            dict[entry.key.rawValue] = entry.value
        }
        bundles[type.language] = mapped
    }
    
    /// Retrieves the localized string for the given key and language.
    ///
    /// If the key is not found in the specified language bundle, this method returns `nil`.
    ///
    /// - Parameters:
    ///   - rawKey: The raw string key associated with the localized string.
    ///   - language: The `SupportedLanguage` to look up.
    /// - Returns: The localized string if available, or `nil` if not found.
    public static func get(_ rawKey: String, for language: SupportedLanguage) -> String? {
        bundles[language]?[rawKey]
    }
}