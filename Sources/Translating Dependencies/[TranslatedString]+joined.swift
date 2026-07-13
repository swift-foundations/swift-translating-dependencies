//
//  [TranslatedString]+joined.swift
//  swift-translating-dependencies
//
//  Language-dependent list joining/formatting (rides the \.languages-reading
//  closure initializer). Moved from swift-translating's umbrella
//  (decomposition W3, C-translating).
//

public import Translated
public import Translated_String

extension [TranslatedString] {
    public func joined(separator: [String].Separator) -> TranslatedString {
        .perLanguage({ language in
            self.map { $0(language) }.joined(separator: separator)(language)
        })
    }

    public func joined(separator: String) -> TranslatedString {
        .perLanguage({ language in
            self.map { $0(language) }.joined(separator: separator)
        })
    }
}
