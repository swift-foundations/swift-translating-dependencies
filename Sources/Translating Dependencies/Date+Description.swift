//
//  Date+Description.swift
//  swift-translating-dependencies
//
//  Created by Coen ten Thije Boonkkamp on 25/07/2025.
//

import Dependencies
public import Foundation
import Language
import Translated
public import Translated_String
import Translating_Platform

extension Date {
    public func description(
        dateStyle: DateFormatter.Style = .long,
        timeStyle: DateFormatter.Style = .none
    ) -> TranslatedString {
        @Dependency(\.language) var currentLanguage
        @Dependency(\.languages) var languages

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle

        let format: (Language) -> String = { language in
            dateFormatter.locale = language.locale
            return dateFormatter.string(from: self)
        }

        return .init(
            default: format(currentLanguage),
            dictionary: Dictionary(uniqueKeysWithValues: languages.map { ($0, format($0)) })
        )
    }
}

extension Date? {
    public func description(
        dateStyle: DateFormatter.Style = .long,
        timeStyle: DateFormatter.Style = .none
    ) -> TranslatedString {
        @Dependency(\.language) var currentLanguage
        @Dependency(\.languages) var languages

        let format: (Language) -> String = { language in
            switch (dateStyle, timeStyle) {
            case (.none, .none):
                if let date = self {
                    return date.description(dateStyle: dateStyle, timeStyle: timeStyle)(language)
                } else {
                    return Date.placeholder()(language)
                }

            case (.none, _):
                if let date = self {
                    return date.description(dateStyle: dateStyle, timeStyle: timeStyle)(language)
                } else {
                    return "__:__))"
                }

            default:
                if let date = self {
                    return date.description(dateStyle: dateStyle, timeStyle: timeStyle)(language)
                } else {
                    return Date.placeholder()(language)
                }
            }
        }

        return .init(
            default: format(currentLanguage),
            dictionary: Dictionary(uniqueKeysWithValues: languages.map { ($0, format($0)) })
        )
    }
}
