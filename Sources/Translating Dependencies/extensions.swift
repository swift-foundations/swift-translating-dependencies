import Dependencies
public import Language
public import Translated

extension Translated {

    @available(
        *,
        deprecated,
        message:
            "Use dictionary literal syntax instead for better performance. This initializer calls the closure for every language in the dependency."
    )
    public init(
        _ closure: (Language) -> A
    ) {
        self = .mapping(closure)
    }

    internal static func mapping(
        _ closure: (Language) -> A
    ) -> Self {
        @Dependency(\.language) var language
        @Dependency(\.languages) var languages

        return .init(
            default: closure(language),
            dictionary: Dictionary(uniqueKeysWithValues: languages.map { ($0, closure($0)) })
        )
    }
}
