import SwiftUI

/// An observable settings model that exposes language override options for SwiftUI views.
///
/// `LocalizerSettings` allows apps to bind to the selected language and override preference,
/// enabling real-time UI updates when the user chooses a different localization.
/// This class is intended to be used in views via `@StateObject` or `@ObservedObject`.
@MainActor
public final class LocalizerSettings: ObservableObject {

    /// Public init function
    public init() {}
    
    /// A Boolean value that determines whether the app should override the system’s preferred languages.
    ///
    /// When set to `true`, the app uses the language specified by `selectedLanguage`.
    /// When `false`, localization follows the system’s `Locale.preferredLanguages`.
    @AppStorage("Localizer.overrideSystemLanguages")
    public var overrideSystemLanguages: Bool = false
    
    /// The selected language to use when overriding system preferences.
    ///
    /// This value is stored persistently using `@AppStorage`, and must correspond
    /// to a registered localization in `LocalizerRegistry` to take effect.
    /// Defaults to `.en`.
    @AppStorage("Localizer.selectedLanguage")
    public var selectedLanguage: SupportedLanguage = .en
    
    /// The currently active language used for localization.
    ///
    /// This value reflects the current override settings:
    /// - If overriding is enabled and the selected language is valid and supported, it is returned.
    /// - Otherwise, the system's preferred languages are used via `SupportedLanguage.fromDeviceLanguage()`.
    public var currentLanguage: SupportedLanguage {
        if overrideSystemLanguages, LocalizerRegistry.supports(selectedLanguage) {
           return selectedLanguage
        }
        return SupportedLanguage.fromDeviceLanguage()
    }
}