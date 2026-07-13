//
//  LanguagesKey.swift
//  swift-translating-dependencies
//
//  Created by Coen ten Thije Boonkkamp on 30/12/2024.
//

public import Dependencies
public import Language

/// Dependency key for managing the set of languages used in translation contexts.
///
/// This key defines which languages should be included when creating translated content,
/// allowing fine-grained control over which translations are generated and cached.
private enum LanguagesKey: Dependency.Key {}

extension LanguagesKey {
    /// Live value includes all supported languages
    static let liveValue: Swift.Set<Language> = .supported

    /// Test value includes all supported languages for comprehensive testing
    static let testValue: Swift.Set<Language> = .supported
}

extension Swift.Set<Language> {
    /// The full set of supported languages matching the original Language enum cases.
    ///
    /// This collection replaces the former `Language.allCases` with an explicit policy set.
    /// Languages not in this set can still be used directly but won't be included in
    /// bulk translation operations.
    public static let supported: Self = [
        .abkhazian, .afar, .afrikaans, .akan, .albanian, .amharic, .arabic,
        .aragonese, .armenian, .assamese, .avaric, .avestan, .aymara,
        .azerbaijani, .bambara, .bashkir, .basque, .belarusian, .bengali,
        .bihari, .bislama, .bosnian, .breton, .bulgarian, .burmese,
        .catalan, .chamorro, .chechen, .chinese, .chuvash, .cornish,
        .corsican, .cree, .croatian, .czech, .danish, .dutch, .dzongkha,
        .english, .esperanto, .estonian, .ewe, .faroese, .fijian, .finnish,
        .french, .galician, .gaelicScottish, .georgian, .german, .greek,
        .guarani, .gujarati, .haitianCreole, .hausa, .hebrew, .herero,
        .hindi, .hiriMotu, .hungarian, .icelandic, .ido, .igbo,
        .indonesian, .interlingua, .interlingue, .inuktitut, .inupiak,
        .irish, .italian, .japanese, .javanese, .kannada, .kanuri,
        .kashmiri, .kazakh, .khmer, .kikuyu, .kinyarwanda, .kirundi,
        .komi, .kongo, .korean, .kurdish, .kwanyama, .kyrgyz, .lao,
        .latin, .latvian, .limburgish, .lingala, .lithuanian, .lugaKatanga,
        .luxembourgish, .macedonian, .malagasy, .malay, .malayalam,
        .maltese, .manx, .maori, .marathi, .marshallese, .moldavian,
        .mongolian, .nauru, .navajo, .ndonga, .nepali, .northernNdebele,
        .norwegian, .norwegianBokmål, .norwegianNynorsk, .occitan, .ojibwe,
        .oriya, .oromo, .ossetian, .pāli, .persian, .polish, .portuguese,
        .punjabi, .quechua, .romanian, .romansh, .russian, .sami, .samoan,
        .sango, .sanskrit, .serbian, .serboCroatian, .sesotho, .setswana,
        .shona, .sindhi, .sinhalese, .slovak, .slovenian, .somali,
        .southernNdebele, .spanish, .sundanese, .swahili, .swati, .swedish,
        .tagalog, .tahitian, .tajik, .tamil, .tatar, .telugu, .thai,
        .tibetan, .tigrinya, .tonga, .tsonga, .turkish, .turkmen, .twi,
        .ukrainian, .urdu, .uyghur, .uzbek, .venda, .vietnamese, .volapük,
        .wallon, .welsh, .westernFrisian, .wolof, .xhosa, .yoruba, .zulu,
        .auEnglish, .caEnglish, .ukEnglish, .usEnglish,
    ]
}

extension Dependency.Values {
    /// The set of languages to use when creating translated content.
    ///
    /// This dependency controls which languages are included when:
    /// - Creating `Translated` instances with closure-based initializers
    /// - Determining which translations to generate or cache
    /// - Filtering language-specific operations
    ///
    /// ## Usage
    ///
    /// ```swift
    /// // Limit translations to specific languages
    /// withDependencies {
    ///     $0.languages = [.english, .dutch, .french]
    /// } operation: {
    ///     let translated = Translated { language in
    ///         // Only called for English, Dutch, and French
    ///         lookupTranslation(for: language)
    ///     }
    /// }
    /// ```
    ///
    /// - Note: Defaults to all supported languages in production
    public var languages: Swift.Set<Language> {
        get { self[LanguagesKey.self] }
        set { self[LanguagesKey.self] = newValue }
    }
}
