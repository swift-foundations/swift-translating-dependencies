public import Translated
public import Translated_String

extension [TranslatedString] {
    public func joined(separator: [String].Separator) -> TranslatedString {
        .mapping({ language in
            self.map { $0(language) }.joined(separator: separator)(language)
        })
    }

    public func joined(separator: String) -> TranslatedString {
        .mapping({ language in
            self.map { $0(language) }.joined(separator: separator)
        })
    }
}
