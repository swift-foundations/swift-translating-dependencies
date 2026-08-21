public import Dependencies
public import Language

private enum LanguagesKey: Dependency.Key {}

extension LanguagesKey {

    static let liveValue: Swift.Set<Language> = .supported

    static let testValue: Swift.Set<Language> = .supported
}

extension Swift.Set<Language> {

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

    public var languages: Swift.Set<Language> {
        get { self[LanguagesKey.self] }
        set { self[LanguagesKey.self] = newValue }
    }
}
