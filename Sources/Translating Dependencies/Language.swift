public import Dependencies
public import Language
public import Translated

extension Dependency.Values {

    public var language: Language {
        get { self[Language.self] }
        set { self[Language.self] = newValue }
    }
}

extension Language: @retroactive Dependency.Key {

    public static var liveValue: Self {
        .english
    }

    public static var testValue: Self {
        .english
    }

    public static var previewValue: Self {
        .english
    }
}

extension Translated: @retroactive CustomStringConvertible where A == String {

    public var description: String {
        @Dependency(\.language) var language
        return self[language]
    }
}

extension Translated: @retroactive Comparable where A: Comparable {

    public static func < (lhs: Translated<A>, rhs: Translated<A>) -> Bool {
        @Dependency(\.language) var language
        return lhs[language] < rhs[language]
    }
}
