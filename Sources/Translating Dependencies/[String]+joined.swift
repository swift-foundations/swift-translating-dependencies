public import Language
public import Translated
public import Translated_String

extension [String] {

    public func joined(language: Language, separator: [String].Separator) -> String {
        self.joined(separator: TranslatedString(separator)(language))
    }
}

extension [String] {

    public func joined(separator: TranslatedString) -> TranslatedString {
        .mapping({ language in
            self.joined(separator: separator(language))
        })
    }
}

extension [String] {

    public func joined(separator: [String].Separator) -> TranslatedString {
        guard !self.isEmpty else { return "" }
        guard self.count > 1 else { return .init(self[0]) }

        return .mapping({ language in
            let localizedSeparator = TranslatedString(separator)(language)

            if self.count == 2 {
                return "\(self[0]) \(localizedSeparator) \(self[1])"
            }

            let allButLast = Array(self.dropLast())
            let lastItem = self.last!
            return "\(allButLast.joined(separator: ", ")), \(localizedSeparator) \(lastItem)"
        })
    }
}

extension [String] {

    public func formattedList(separator: ListSeparator = .and) -> Translated<Self> {
        .mapping({ _ in
            switch separator {
            case .and:
                return self.formattedItems(with: "and")

            case .or:
                return self.formattedItems(with: "or")

            case .individual:
                return self.formattedItems(with: "")
            }
        })
    }
}
