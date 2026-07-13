//
//  File.swift
//
//
//  Created by Coen ten Thije Boonkkamp on 19/07/2024.
//

import Dependencies
import Dependencies_Test_Support
import Foundation
import Testing

import Language
import Translated
import Translated_String

@testable import Translating_Dependencies

@Suite(
    .dependency(\.language, .english)
)
struct `Translating Tests` {

    @Suite
    struct `Closure Based Initializer` {

        @Test
        func `Closure initializer uses languages dependency`() {
            let customLanguages: Set<Language> = [.dutch, .french, .german]

            withDependencies {
                $0.languages = customLanguages
            } operation: {
                let translated = Translated<String> { language in
                    switch language {
                    case .dutch: return "Hallo"
                    case .french: return "Bonjour"
                    case .german: return "Hallo"
                    default: return "Hello"
                    }
                }

                // Should only contain the languages in the dependency
                #expect(translated[.dutch] == "Hallo")
                #expect(translated[.french] == "Bonjour")
                #expect(translated[.german] == "Hallo")
                #expect(translated[.spanish] == "Hello")  // Falls back to default
            }
        }

        @Test
        func `Closure initializer with limited languages dependency`() {
            let limitedLanguages: Set<Language> = [.dutch, .english]

            withDependencies {
                $0.languages = limitedLanguages
            } operation: {
                let translated = Translated<String> { language in
                    "Content for \(language)"
                }

                #expect(translated[.dutch] == "Content for nl")  // Has Dutch translation
                // Has English translation (also the default)
                #expect(translated[.english] == "Content for en")
                #expect(translated[.french] == "Content for en")  // Falls back to default
                #expect(translated[.german] == "Content for en")  // Falls back to default
            }
        }
    }

    @Suite
    struct `Mass Initializer Dependencies` {

        @Test
        func `Mass initializer respects languages dependency`() {
            let customLanguages: Set<Language> = [.dutch, .french]

            withDependencies {
                $0.languages = customLanguages
            } operation: {
                let translated = Translated(
                    "Default",
                    dutch: "Hallo",
                    french: "Bonjour",
                    german: "Hallo",  // This should be ignored
                    spanish: "Hola"  // This should be ignored
                )

                // Only Dutch and French should be in dictionary
                #expect(translated[.dutch] == "Hallo")
                #expect(translated[.french] == "Bonjour")
                #expect(translated[.german] == "Default")  // Falls back to default
                #expect(translated[.spanish] == "Default")  // Falls back to default
            }
        }

        @Test
        func `Mass initializer with no matching languages`() {
            let customLanguages: Set<Language> = [.italian, .portuguese]

            withDependencies {
                $0.languages = customLanguages
            } operation: {
                let translated = Translated(
                    "Default",
                    dutch: "Hallo",
                    french: "Bonjour",
                    german: "Hallo"
                )

                // No languages should match
                #expect(translated[.dutch] == "Default")  // Falls back to default
                #expect(translated[.french] == "Default")  // Falls back to default
                #expect(translated[.german] == "Default")  // Falls back to default
            }
        }
    }

    @Suite
    struct `Custom String Convertible` {

        @Test
        func `Description uses current language dependency`() {
            let translated = Translated(
                "Default",
                dutch: "Hallo",
                french: "Bonjour",
                german: "Hallo"
            )

            withDependencies {
                $0.language = .dutch
            } operation: {
                #expect(translated.description == "Hallo")
            }

            withDependencies {
                $0.language = .french
            } operation: {
                #expect(translated.description == "Bonjour")
            }

            withDependencies {
                $0.language = .spanish  // Falls back to default
            } operation: {
                #expect(translated.description == "Default")
            }
        }
    }

    @Suite
    struct `Comparable With Dependencies` {

        @Test
        func `Comparison uses current language dependency`() {
            let translated1 = Translated(
                "Apple",
                dutch: "Appel",
                french: "Pomme"
            )
            let translated2 = Translated(
                "Banana",
                dutch: "Banaan",
                french: "Banane"
            )

            withDependencies {
                $0.language = .english
            } operation: {
                #expect(translated1 < translated2)  // "Apple" < "Banana"
            }

            withDependencies {
                $0.language = .dutch
            } operation: {
                #expect(translated1 < translated2)  // "Appel" < "Banaan"
            }

            withDependencies {
                $0.language = .french
            } operation: {
                #expect(translated2 < translated1)  // "Banane" < "Pomme"
            }
        }
    }

    @Suite
    struct `Edge Cases With Dependencies` {

        @Test
        func `Empty languages dependency`() {
            let emptyLanguages: Set<Language> = []

            withDependencies {
                $0.languages = emptyLanguages
            } operation: {
                let translated = Translated<String> { language in
                    "Content for \(language)"
                }

                #expect(translated[.french] == "Content for en")  // Falls back to default
                #expect(translated[.german] == "Content for en")  // Falls back to default
            }
        }

        @Test
        func `Single language dependency`() {
            let singleLanguage: Set<Language> = [.french]

            withDependencies {
                $0.languages = singleLanguage
            } operation: {
                let translated = Translated(
                    "Default",
                    dutch: "Hallo",
                    french: "Bonjour",
                    german: "Hallo"
                )

                #expect(translated[.french] == "Bonjour")
                #expect(translated[.dutch] == "Default")  // Falls back to default
                #expect(translated[.german] == "Default")  // Falls back to default
            }
        }

        @Test
        func `Dependency changes don't affect existing instances`() {
            var translated: Translated<String>!

            withDependencies {
                $0.languages = [.dutch, .french]
            } operation: {
                translated = Translated(
                    "Default",
                    dutch: "Hallo",
                    french: "Bonjour",
                    german: "Hallo"
                )
            }

            // Translated instance should maintain its original dictionary
            #expect(translated[.dutch] == "Hallo")
            #expect(translated[.french] == "Bonjour")
            #expect(translated[.german] == "Default")  // Not included in original dependency

            // Even if we change the dependency later
            withDependencies {
                $0.languages = [.german]
            } operation: {
                // Original instance unchanged
                #expect(translated[.dutch] == "Hallo")
                #expect(translated[.french] == "Bonjour")
                #expect(translated[.german] == "Default")  // Still not in original instance
            }
        }
    }
}
