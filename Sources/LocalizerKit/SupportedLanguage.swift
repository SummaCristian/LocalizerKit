import Foundation

/// This enum contains all the languages the app can be localized in.
/// Each language provides its name (it its language) and the representative country's flag emoji
public enum SupportedLanguage: String, CaseIterable, Codable {
    case en, it, fr, de, es, pt, nl, sv, da, fi
    case pl, cs, ro, hu, el, tr, ru, uk, he, ar
    case hi, zh, ja, ko, vi, th, id, ms, no, fa
    
    /// Returns the language's localized name
    public var displayName: String {
        switch self {
        case .en: "English"
        case .it: "Italiano"
        case .fr: "Français"
        case .de: "Deutsch"
        case .es: "Español"
        case .pt: "Português"
        case .nl: "Nederlands"
        case .sv: "Svenska"
        case .da: "Dansk"
        case .fi: "Suomi"
        case .pl: "Polski"
        case .cs: "Čeština"
        case .ro: "Română"
        case .hu: "Magyar"
        case .el: "Ελληνικά"
        case .tr: "Türkçe"
        case .ru: "Русский"
        case .uk: "Українська"
        case .he: "עברית"
        case .ar: "العربية"
        case .hi: "हिन्दी"
        case .zh: "中文"
        case .ja: "日本語"
        case .ko: "한국어"
        case .vi: "Tiếng Việt"
        case .th: "ไทย"
        case .id: "Bahasa Indonesia"
        case .ms: "Bahasa Melayu"
        case .no: "Norsk"
        case .fa: "فارسی"
        }
    }
    
    /// Returns the flag emoji for the main country the language is spoken in
    public var flag: String {
        switch self {
        case .en: "🇬🇧"
        case .it: "🇮🇹"
        case .fr: "🇫🇷"
        case .de: "🇩🇪"
        case .es: "🇪🇸"
        case .pt: "🇵🇹"
        case .nl: "🇳🇱"
        case .sv: "🇸🇪"
        case .da: "🇩🇰"
        case .fi: "🇫🇮"
        case .pl: "🇵🇱"
        case .cs: "🇨🇿"
        case .ro: "🇷🇴"
        case .hu: "🇭🇺"
        case .el: "🇬🇷"
        case .tr: "🇹🇷"
        case .ru: "🇷🇺"
        case .uk: "🇺🇦"
        case .he: "🇮🇱"
        case .ar: "🇸🇦"
        case .hi: "🇮🇳"
        case .zh: "🇨🇳"
        case .ja: "🇯🇵"
        case .ko: "🇰🇷"
        case .vi: "🇻🇳"
        case .th: "🇹🇭"
        case .id: "🇮🇩"
        case .ms: "🇲🇾"
        case .no: "🇳🇴"
        case .fa: "🇮🇷"
        }
    }
    
    //// Returns the appropriate enum value based on the device's preferred languages.
    ///
    /// This method returns the first language that matches both the user's preferences
    /// and the app's registered localizations. If no match is found, it defaults to `.en`.
    ///
    /// - Returns: The best matching `SupportedLanguage`, or `.en` if none are registered.
    public static func fromDeviceLanguage() -> SupportedLanguage {
        fromDeviceLanguages().first ?? .en
    }
    
    /// Returns a prioritized list of supported languages that match the user's preferred languages.
    ///
    /// This method iterates over the user's preferred language codes and returns only those
    /// that are both valid `SupportedLanguage` cases and have been registered in the `LocalizerRegistry`.
    ///
    /// The result preserves the original order of `Locale.preferredLanguages`, filtered to only include
    /// languages your app has localizations for (i.e., registered via `LocalizerRegistry`).
    ///
    /// - Returns: An array of `SupportedLanguage` values sorted by the user's preferences, containing only supported and registered languages.
    public static func fromDeviceLanguages() -> [SupportedLanguage] {
        Locale.preferredLanguages.compactMap { langCode in
            let code = String(langCode.prefix(2))
            if let language = SupportedLanguage(rawValue: code),
               LocalizerRegistry.supports(language) {
                return language
            }
            return nil
        }
    }
}
