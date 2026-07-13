//
//  Language Dependency Tests.swift
//  swift-translating-dependencies
//
//  Created by Coen ten Thije Boonkkamp on 25/07/2025.
//

import Dependencies
import Dependencies_Test_Support
import Language
import Testing
import Translated
import Translated_String

@testable import Translating_Dependencies

@Suite(
    .dependency(\.language, .english)
)
struct `Language Dependency Tests` {

    @Suite
    struct `Language Dependency Integration` {

        @Test
        func `Language dependency returns current language`() {
            withDependencies {
                $0.language = .dutch
            } operation: {
                @Dependency(\.language) var language
                #expect(language == .dutch)
            }

            withDependencies {
                $0.language = .french
            } operation: {
                @Dependency(\.language) var language
                #expect(language == .french)
            }
        }

        @Test
        func `Language dependency has correct default values`() {
            #expect(Language.liveValue == .english)
            #expect(Language.testValue == .english)
            #expect(Language.previewValue == .english)
        }

        @Test
        func `Languages dependency provides all languages by default`() {
            withDependencies { _ in
                // Using default dependency values
            } operation: {
                @Dependency(\.languages) var languages
                #expect(languages.count == Set<Language>.supported.count)
                #expect(languages.contains(.english))
                #expect(languages.contains(.dutch))
                #expect(languages.contains(.french))
            }
        }

        @Test
        func `Languages dependency can be overridden`() {
            let customLanguages: Set<Language> = [.dutch, .french]

            withDependencies {
                $0.languages = customLanguages
            } operation: {
                @Dependency(\.languages) var languages
                #expect(languages == customLanguages)
                #expect(languages.count == 2)
                #expect(languages.contains(.dutch))
                #expect(languages.contains(.french))
                #expect(!languages.contains(.german))
            }
        }
    }

}
