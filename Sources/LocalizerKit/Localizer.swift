import Foundation

/// This struct provides the localized version of any String based
/// on its LocalizedKey enum value.
/// It is a static struct, meaning it doesn't need to be initialized.
public struct Localizer {
    /// Indicates whether to override system language preferences.
    @AppStorage("Localizer.overrideSystemLanguages")
    public static var overrideSystemLanguages: Bool = false
    
    /// Stores the rawValue of the selected language if overriding is enabled.
    @AppStorage("Localizer.selectedLanguage")
    public static var selectedLanguageRawValue: String = "en"
    
    /// Returns the currently active language, based on system or override
    public static var currentLanguage: SupportedLanguage {
        if overrideSystemLanguages,
           let lang = SupportedLanguage(rawValue: selectedLanguageRawValue),
           LocalizerRegistry.supports(lang) {
            return lang
        }
        
        return SupportedLanguage.fromDeviceLanguage()
    }
    
    /// Returns the localized string associated with the given key, optionally in a specific language.
    ///
    /// This method checks the specified language's localization bundle first. If the key is not found,
    /// it automatically falls back to English. If the key is missing in both, it returns a placeholder
    /// string prefixed with `"MISSING:"`.
    ///
    /// - Parameters:
    ///   - key: The key representing the localized string, conforming to `LocalizedKeyProtocol`.
    ///   - language: The language in which to retrieve the string. Defaults to `currentLanguage`.
    /// - Returns: The localized string, a fallback in English, or a `"MISSING:"` message.
    public static func get(
        _ key: any LocalizedKeyProtocol,
        in language: SupportedLanguage = currentLanguage)
    -> String {
        // Attempts to localzied in the chosen Locale if possible.
        // If not, it attempts to localize in English.
        // If the key can't be found in there either, it returns a standard MISSING String
        return LocalizerRegistry.get(key.rawValue, for: language)
        ?? LocalizerRegistry.get(key.rawValue, for: .en)
        ?? "MISSING: \(key.rawValue)"
    }
    
    /// The list of supported languages currently registered in the app
    public static var availableLanguages: [SupportedLanguage] {
        SupportedLanguage.allCases.filter { LocalizerRegistry.supports($0) }
    }
}