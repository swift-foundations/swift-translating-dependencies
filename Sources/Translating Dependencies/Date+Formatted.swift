import Dependencies
public import Foundation
import Language
public import Translated_String
import Translating_Platform

extension Date {

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
