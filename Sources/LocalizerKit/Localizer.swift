import Foundation

/// This struct provides the localized version of any String based
/// on its LocalizedKey enum value.
/// It is a static struct, meaning it doesn't need to be initialized.
public struct Localizer {
    //    @AppStorage("preferredLanguage") public static var preferredLanguage: SupportedLanguage?
    
    /// Returns the localized version of a String based on its LocalizedKey
    public static func get(_ key: any LocalizedKeyProtocol) -> String {
        // Reads the current locale
        let lang = SupportedLanguage.fromDeviceLanguage()
        
        // Attempts to localzied in the chosen Locale if possible.
        // If not, it attempts to localize in English.
        // If the key can't be found in there either, it returns a standard MISSING String
        return LocalizerRegistry.get(key.rawValue, for: lang)
        ?? LocalizerRegistry.get(key.rawValue, for: .en)
        ?? "MISSING: \(key.rawValue)"
    }
}
