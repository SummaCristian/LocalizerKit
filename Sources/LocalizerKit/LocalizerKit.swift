@_exported import SwiftUI

public typealias LocalizerKey = any LocalizedKeyProtocol

// Optional: group useful types into a namespace if desired
public struct LocalizerKit {
    public typealias Language = SupportedLanguage
    public typealias Registry = LocalizerRegistry
    public typealias KeyProtocol = LocalizedKeyProtocol
    public typealias LanguageDefinition = LocalizedLanguage
}