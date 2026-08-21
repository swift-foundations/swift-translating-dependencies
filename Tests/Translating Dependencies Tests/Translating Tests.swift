import Dependencies
import Dependencies_Test_Support
import Foundation
import Language
import Testing
import Translated
import Translated_String

@testable import Translating_Dependencies

@Suite(
    .dependency(\.language, .english)
)
struct `Translating Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}

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

                #expect(translated[.dutch] == "Hallo")
                #expect(translated[.french] == "Bonjour")
                #expect(translated[.german] == "Hallo")
                #expect(translated[.spanish] == "Hello")
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

                #expect(translated[.dutch] == "Content for nl")

                #expect(translated[.english] == "Content for en")
                #expect(translated[.french] == "Content for en")
                #expect(translated[.german] == "Content for en")
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
                    german: "Hallo",
                    spanish: "Hola"
                )

                #expect(translated[.dutch] == "Hallo")
                #expect(translated[.french] == "Bonjour")
                #expect(translated[.german] == "Default")
                #expect(translated[.spanish] == "Default")
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

                #expect(translated[.dutch] == "Default")
                #expect(translated[.french] == "Default")
                #expect(translated[.german] == "Default")
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
                $0.language = .spanish
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
                #expect(translated1 < translated2)
            }

            withDependencies {
                $0.language = .dutch
            } operation: {
                #expect(translated1 < translated2)
            }

            withDependencies {
                $0.language = .french
            } operation: {
                #expect(translated2 < translated1)
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

                #expect(translated[.french] == "Content for en")
                #expect(translated[.german] == "Content for en")
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
                #expect(translated[.dutch] == "Default")
                #expect(translated[.german] == "Default")
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

            #expect(translated[.dutch] == "Hallo")
            #expect(translated[.french] == "Bonjour")
            #expect(translated[.german] == "Default")

            withDependencies {
                $0.languages = [.german]
            } operation: {

                #expect(translated[.dutch] == "Hallo")
                #expect(translated[.french] == "Bonjour")
                #expect(translated[.german] == "Default")
            }
        }
    }
}
