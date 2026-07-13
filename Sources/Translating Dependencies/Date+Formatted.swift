//
//  Date+Formatted.swift
//  swift-translating-dependencies
//
//  Created by Coen ten Thije Boonkkamp on 06/12/2024.
//

import Dependencies
public import Foundation
import Language
public import Translated_String
import Translating_Platform

extension Date {
    /// Formats a date with optional translation support across multiple languages.
    ///
    /// When `translated` is `true`, the method creates a TranslatedString where each language
    /// gets the date formatted according to its locale conventions.
    ///
    /// - Parameters:
    ///   - date: The date style to use for formatting
    ///   - time: The time style to use for formatting
    ///   - translated: Whether to create translated versions for all languages (if true) or use current locale only (if false/nil)
    /// - Returns: A TranslatedString containing the formatted date, with proper localization if translated=true
    public func formatted(
        date: FormatStyle.DateStyle,
        time: FormatStyle.TimeStyle,
        translated: Bool?
    )
        -> TranslatedString
    {
        guard translated == true else {
            return TranslatedString(self.formatted(date: date, time: time))
        }

        @Dependency(\.language) var currentLanguage
        @Dependency(\.languages) var languages

        let format: (Language) -> String = { language in
            self.formatted(
                Self.FormatStyle(
                    date: date,
                    time: time,
                    locale: language.locale
                )
            )
        }

        return .init(
            default: format(currentLanguage),
            dictionary: Dictionary(uniqueKeysWithValues: languages.map { ($0, format($0)) })
        )
    }
}
