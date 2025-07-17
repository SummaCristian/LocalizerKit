import SwiftUI

/// A ViewModifier that registers all provided localization files as the app’s supported languages.
///
/// The registration process is performed during the modifier’s initialization (`init()`),
/// ensuring the `Localizer` is fully configured before any localized UI is rendered.
public struct LocalizedAppModifier: ViewModifier {
    /// The list of localization structs, each conforming to the `LocalizedLanguage` protocol.
    private let languages: [any LocalizedLanguage.Type]
    
    /// Initializes the modifier with the given array of `LocalizedLanguage` types.
    ///
    /// The registration is performed immediately, allowing localization
    /// to be available as early as view construction.
    public init(in languages: [any LocalizedLanguage.Type]) {
        self.languages = languages
        self.register()
    }
    
    /// Registers each `LocalizedLanguage` type with the `LocalizerRegistry`.
    private func register() {
        for language in languages {
            LocalizerRegistry.register(language)
        }
    }
    
    public func body(content: Content) -> some View {
        content
    }
}

/// Extension to `View` that enables the `localized(in:)` modifier,
/// which registers the provided localization files for use in the app.
public extension View {
    /// Registers the given array of `LocalizedLanguage` structs as the available localizations.
    ///
    /// This should be called **once**, ideally at the root of your app's view hierarchy (e.g. in `App` or `Scene`),
    /// to make sure all translations are properly available during UI rendering.
    ///
    /// - Parameter languages: A list of types conforming to `LocalizedLanguage`.
    /// - Returns: The original view, unmodified.
    func localized(in languages: [any LocalizedLanguage.Type]) -> some View {
        self.modifier(LocalizedAppModifier(in: languages))
    }
}