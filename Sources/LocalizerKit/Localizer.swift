import Foundation
import SwiftUI

/// A static interface for retrieving localized strings based on the app's selected or system language.
///
/// `Localizer` provides convenient access to localization lookup, automatic language override handling,
/// and a filtered list of available languages registered with `LocalizerRegistry`.
public struct Localizer {
    
    /// A Boolean value that determines whether the app should override the system’s preferred languages.
    ///
    /// When `true`, `selectedLanguage` is used for localization instead of `Locale.preferredLanguages`.
    @AppStorage("Localizer.overrideSystemLanguages")
    public static var overrideSystemLanguages: Bool = false

    /// The currently selected app language used when overriding system preferences.
    ///
    /// This value is stored using `@AppStorage` and defaults to `.en`.
    @AppStorage("Localizer.selectedLanguage")
    public static var selectedLanguage: SupportedLanguage = .en

    /// Returns the language that should be used for localization, based on override and registration status.
    public static var currentLanguage: SupportedLanguage {
        if overrideSystemLanguages,
           LocalizerRegistry.supports(selectedLanguage) {
            return selectedLanguage
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
        in language: SupportedLanguage = currentLanguage
    ) -> String {
        LocalizerRegistry.get(key.rawValue, for: language)
        ?? LocalizerRegistry.get(key.rawValue, for: .en)
        ?? "MISSING: \(key.rawValue)"
    }

    /// Returns the list of all supported languages currently registered in the app.
    public static var availableLanguages: [SupportedLanguage] {
        SupportedLanguage.allCases.filter { LocalizerRegistry.supports($0) }
    }
}