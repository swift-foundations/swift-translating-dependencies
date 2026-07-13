//
//  Language.swift
//  swift-translating-dependencies
//
//  Created by Coen ten Thije Boonkkamp on 17-12-2023.
//

public import Dependencies
public import Language
public import Translated

extension Dependency.Values {
    /// The current language to use for localization and translation.
    ///
    /// This dependency determines which language is used when:
    /// - Displaying `TranslatedString` instances via `description`
    /// - Comparing `Translated` instances
    /// - Resolving language-specific behavior
    ///
    /// ## Usage
    ///
    /// ```swift
    /// @Dependency(\.language) var language
    /// let translatedText = someTranslatedString.description // Uses current language
    ///
    /// // Override language for specific operations
    /// withDependencies {
    ///     $0.language = .dutch
    /// } operation: {
    ///     print(someTranslatedString) // Displays Dutch translation
    /// }
    /// ```
    ///
    /// - Note: Defaults to English. Install a Platform resolver for system language detection.
    public var language: Language {
        get { self[Language.self] }
        set { self[Language.self] = newValue }
    }
}

/// Conformance to Dependency.Key allows Language to be used as a dependency.
///
/// Defaults to English as a safe fallback. For system language detection based on
/// locale, install the resolver from the `Translating Platform` module.
extension Language: @retroactive Dependency.Key {
    /// Live value defaults to English as the fallback language
    public static var liveValue: Self {
        .english
    }

    /// Test value defaults to English for deterministic tests
    public static var testValue: Self {
        .english
    }

    /// Preview value defaults to English
    public static var previewValue: Self {
        .english
    }
}

/// String representation support for Translated<String> types using current language dependency.
extension Translated: @retroactive CustomStringConvertible where A == String {
    /// Returns the translation for the current language dependency.
    ///
    /// This allows `TranslatedString` instances to be used directly in string contexts,
    /// automatically selecting the appropriate translation based on the current language.
    ///
    /// ```swift
    /// let greeting = TranslatedString(english: "Hello", dutch: "Hallo")
    ///
    /// withDependencies { $0.language = .dutch } operation: {
    ///     print("\(greeting)!")  // Prints "Hallo!"
    /// }
    /// ```
    public var description: String {
        @Dependency(\.language) var language
        return self[language]
    }
}

/// Comparison support for Translated types using current language dependency.
extension Translated: @retroactive Comparable where A: Comparable {
    /// Compares two Translated instances using the current language dependency.
    ///
    /// The comparison uses the translations for the current language, allowing
    /// for language-aware sorting and ordering of translated content.
    ///
    /// ```swift
    /// let items = [
    ///     TranslatedString(english: "Apple", dutch: "Appel"),
    ///     TranslatedString(english: "Banana", dutch: "Banaan")
    /// ]
    ///
    /// withDependencies { $0.language = .dutch } operation: {
    ///     let sorted = items.sorted() // Sorts using Dutch translations
    /// }
    /// ```
    public static func < (lhs: Translated<A>, rhs: Translated<A>) -> Bool {
        @Dependency(\.language) var language
        return lhs[language] < rhs[language]
    }
}
