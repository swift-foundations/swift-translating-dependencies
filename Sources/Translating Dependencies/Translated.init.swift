//
//  Translated.init.swift
//  swift-translating-dependencies
//
//  The 180-label, \.languages-filtering mass initializer (package access:
//  its only caller is the english-non-optional public wrapper beside it).
//  Moved from swift-translating (decomposition W3, C-translating).
//

import Dependencies
import Language
package import Translated

extension Translated {
    package init(
        _ `default`: A,
        abkhazian: A? = nil,
        afar: A? = nil,
        afrikaans: A? = nil,
        akan: A? = nil,
        albanian: A? = nil,
        amharic: A? = nil,
        arabic: A? = nil,
        aragonese: A? = nil,
        armenian: A? = nil,
        assamese: A? = nil,
        auEnglish: A? = nil,
        avaric: A? = nil,
        avestan: A? = nil,
        aymara: A? = nil,
        azerbaijani: A? = nil,
        bambara: A? = nil,
        bashkir: A? = nil,
        basque: A? = nil,
        belarusian: A? = nil,
        bengali: A? = nil,
        bihari: A? = nil,
        bislama: A? = nil,
        bosnian: A? = nil,
        breton: A? = nil,
        bulgarian: A? = nil,
        burmese: A? = nil,
        caEnglish: A? = nil,
        catalan: A? = nil,
        chamorro: A? = nil,
        chechen: A? = nil,
        chinese: A? = nil,
        chuvash: A? = nil,
        cornish: A? = nil,
        corsican: A? = nil,
        cree: A? = nil,
        croatian: A? = nil,
        czech: A? = nil,
        danish: A? = nil,
        dutch: A? = nil,
        dzongkha: A? = nil,
        english: A? = nil,
        esperanto: A? = nil,
        estonian: A? = nil,
        ewe: A? = nil,
        faroese: A? = nil,
        fijian: A? = nil,
        finnish: A? = nil,
        french: A? = nil,
        galician: A? = nil,
        gaelicScottish: A? = nil,
        georgian: A? = nil,
        german: A? = nil,
        greek: A? = nil,
        guarani: A? = nil,
        gujarati: A? = nil,
        haitianCreole: A? = nil,
        hausa: A? = nil,
        hebrew: A? = nil,
        herero: A? = nil,
        hindi: A? = nil,
        hiriMotu: A? = nil,
        hungarian: A? = nil,
        icelandic: A? = nil,
        ido: A? = nil,
        igbo: A? = nil,
        indonesian: A? = nil,
        interlingua: A? = nil,
        interlingue: A? = nil,
        inuktitut: A? = nil,
        inupiak: A? = nil,
        irish: A? = nil,
        italian: A? = nil,
        japanese: A? = nil,
        javanese: A? = nil,
        kannada: A? = nil,
        kanuri: A? = nil,
        kashmiri: A? = nil,
        kazakh: A? = nil,
        khmer: A? = nil,
        kikuyu: A? = nil,
        kinyarwanda: A? = nil,
        kirundi: A? = nil,
        komi: A? = nil,
        kongo: A? = nil,
        korean: A? = nil,
        kurdish: A? = nil,
        kwanyama: A? = nil,
        kyrgyz: A? = nil,
        lao: A? = nil,
        latin: A? = nil,
        latvian: A? = nil,
        limburgish: A? = nil,
        lingala: A? = nil,
        lithuanian: A? = nil,
        lugaKatanga: A? = nil,
        luxembourgish: A? = nil,
        macedonian: A? = nil,
        malagasy: A? = nil,
        malay: A? = nil,
        malayalam: A? = nil,
        maltese: A? = nil,
        manx: A? = nil,
        maori: A? = nil,
        marathi: A? = nil,
        marshallese: A? = nil,
        moldavian: A? = nil,
        mongolian: A? = nil,
        nauru: A? = nil,
        navajo: A? = nil,
        ndonga: A? = nil,
        nepali: A? = nil,
        northernNdebele: A? = nil,
        norwegian: A? = nil,
        norwegianBokmål: A? = nil,
        norwegianNynorsk: A? = nil,
        occitan: A? = nil,
        ojibwe: A? = nil,
        oriya: A? = nil,
        oromo: A? = nil,
        ossetian: A? = nil,
        pāli: A? = nil,
        persian: A? = nil,
        polish: A? = nil,
        portuguese: A? = nil,
        punjabi: A? = nil,
        quechua: A? = nil,
        romanian: A? = nil,
        romansh: A? = nil,
        russian: A? = nil,
        sami: A? = nil,
        samoan: A? = nil,
        sango: A? = nil,
        sanskrit: A? = nil,
        serbian: A? = nil,
        serboCroatian: A? = nil,
        sesotho: A? = nil,
        setswana: A? = nil,
        shona: A? = nil,
        sindhi: A? = nil,
        sinhalese: A? = nil,
        slovak: A? = nil,
        slovenian: A? = nil,
        somali: A? = nil,
        southernNdebele: A? = nil,
        spanish: A? = nil,
        sundanese: A? = nil,
        swahili: A? = nil,
        swati: A? = nil,
        swedish: A? = nil,
        tagalog: A? = nil,
        tahitian: A? = nil,
        tajik: A? = nil,
        tamil: A? = nil,
        tatar: A? = nil,
        telugu: A? = nil,
        thai: A? = nil,
        tibetan: A? = nil,
        tigrinya: A? = nil,
        tonga: A? = nil,
        tsonga: A? = nil,
        turkish: A? = nil,
        turkmen: A? = nil,
        twi: A? = nil,
        ukEnglish: A? = nil,
        ukrainian: A? = nil,
        urdu: A? = nil,
        usEnglish: A? = nil,
        uyghur: A? = nil,
        uzbek: A? = nil,
        venda: A? = nil,
        vietnamese: A? = nil,
        volapük: A? = nil,
        wallon: A? = nil,
        welsh: A? = nil,
        westernFrisian: A? = nil,
        wolof: A? = nil,
        xhosa: A? = nil,
        yoruba: A? = nil,
        zulu: A? = nil
    ) {
        @Dependency(\.languages) var languages

        // Build dictionary efficiently by only checking non-nil parameters
        // and using direct dictionary construction instead of compactMapValues
        var dictionary: [Language: A] = [:]
        // Pre-allocate for better performance
        dictionary.reserveCapacity(min(languages.count, 180))

        // Use a closure to reduce code duplication and improve performance
        let addIfIncluded = { (language: Language, value: A?) in
            if let value, languages.contains(language) {
                dictionary[language] = value
            }
        }

        addIfIncluded(.abkhazian, abkhazian)
        addIfIncluded(.afar, afar)
        addIfIncluded(.afrikaans, afrikaans)
        addIfIncluded(.akan, akan)
        addIfIncluded(.albanian, albanian)
        addIfIncluded(.amharic, amharic)
        addIfIncluded(.arabic, arabic)
        addIfIncluded(.aragonese, aragonese)
        addIfIncluded(.armenian, armenian)
        addIfIncluded(.assamese, assamese)
        addIfIncluded(.auEnglish, auEnglish)
        addIfIncluded(.avaric, avaric)
        addIfIncluded(.avestan, avestan)
        addIfIncluded(.aymara, aymara)
        addIfIncluded(.azerbaijani, azerbaijani)
        addIfIncluded(.bambara, bambara)
        addIfIncluded(.bashkir, bashkir)
        addIfIncluded(.basque, basque)
        addIfIncluded(.belarusian, belarusian)
        addIfIncluded(.bengali, bengali)
        addIfIncluded(.bihari, bihari)
        addIfIncluded(.bislama, bislama)
        addIfIncluded(.bosnian, bosnian)
        addIfIncluded(.breton, breton)
        addIfIncluded(.bulgarian, bulgarian)
        addIfIncluded(.burmese, burmese)
        addIfIncluded(.catalan, catalan)
        addIfIncluded(.caEnglish, caEnglish)
        addIfIncluded(.chamorro, chamorro)
        addIfIncluded(.chechen, chechen)
        addIfIncluded(.chinese, chinese)
        addIfIncluded(.chuvash, chuvash)
        addIfIncluded(.cornish, cornish)
        addIfIncluded(.corsican, corsican)
        addIfIncluded(.cree, cree)
        addIfIncluded(.croatian, croatian)
        addIfIncluded(.czech, czech)
        addIfIncluded(.danish, danish)
        addIfIncluded(.dutch, dutch)
        addIfIncluded(.dzongkha, dzongkha)
        addIfIncluded(.english, english)
        addIfIncluded(.esperanto, esperanto)
        addIfIncluded(.estonian, estonian)
        addIfIncluded(.ewe, ewe)
        addIfIncluded(.faroese, faroese)
        addIfIncluded(.fijian, fijian)
        addIfIncluded(.finnish, finnish)
        addIfIncluded(.french, french)
        addIfIncluded(.galician, galician)
        addIfIncluded(.gaelicScottish, gaelicScottish)
        addIfIncluded(.georgian, georgian)
        addIfIncluded(.german, german)
        addIfIncluded(.greek, greek)
        addIfIncluded(.guarani, guarani)
        addIfIncluded(.gujarati, gujarati)
        addIfIncluded(.haitianCreole, haitianCreole)
        addIfIncluded(.hausa, hausa)
        addIfIncluded(.hebrew, hebrew)
        addIfIncluded(.herero, herero)
        addIfIncluded(.hindi, hindi)
        addIfIncluded(.hiriMotu, hiriMotu)
        addIfIncluded(.hungarian, hungarian)
        addIfIncluded(.icelandic, icelandic)
        addIfIncluded(.ido, ido)
        addIfIncluded(.igbo, igbo)
        addIfIncluded(.indonesian, indonesian)
        addIfIncluded(.interlingua, interlingua)
        addIfIncluded(.interlingue, interlingue)
        addIfIncluded(.inuktitut, inuktitut)
        addIfIncluded(.inupiak, inupiak)
        addIfIncluded(.irish, irish)
        addIfIncluded(.italian, italian)
        addIfIncluded(.japanese, japanese)
        addIfIncluded(.javanese, javanese)
        addIfIncluded(.kannada, kannada)
        addIfIncluded(.kanuri, kanuri)
        addIfIncluded(.kashmiri, kashmiri)
        addIfIncluded(.kazakh, kazakh)
        addIfIncluded(.khmer, khmer)
        addIfIncluded(.kikuyu, kikuyu)
        addIfIncluded(.kinyarwanda, kinyarwanda)
        addIfIncluded(.kirundi, kirundi)
        addIfIncluded(.komi, komi)
        addIfIncluded(.kongo, kongo)
        addIfIncluded(.korean, korean)
        addIfIncluded(.kurdish, kurdish)
        addIfIncluded(.kwanyama, kwanyama)
        addIfIncluded(.kyrgyz, kyrgyz)
        addIfIncluded(.lao, lao)
        addIfIncluded(.latin, latin)
        addIfIncluded(.latvian, latvian)
        addIfIncluded(.limburgish, limburgish)
        addIfIncluded(.lingala, lingala)
        addIfIncluded(.lithuanian, lithuanian)
        addIfIncluded(.lugaKatanga, lugaKatanga)
        addIfIncluded(.luxembourgish, luxembourgish)
        addIfIncluded(.macedonian, macedonian)
        addIfIncluded(.malagasy, malagasy)
        addIfIncluded(.malay, malay)
        addIfIncluded(.malayalam, malayalam)
        addIfIncluded(.maltese, maltese)
        addIfIncluded(.manx, manx)
        addIfIncluded(.maori, maori)
        addIfIncluded(.marathi, marathi)
        addIfIncluded(.marshallese, marshallese)
        addIfIncluded(.moldavian, moldavian)
        addIfIncluded(.mongolian, mongolian)
        addIfIncluded(.nauru, nauru)
        addIfIncluded(.navajo, navajo)
        addIfIncluded(.ndonga, ndonga)
        addIfIncluded(.nepali, nepali)
        addIfIncluded(.northernNdebele, northernNdebele)
        addIfIncluded(.norwegian, norwegian)
        addIfIncluded(.norwegianBokmål, norwegianBokmål)
        addIfIncluded(.norwegianNynorsk, norwegianNynorsk)
        addIfIncluded(.occitan, occitan)
        addIfIncluded(.ojibwe, ojibwe)
        addIfIncluded(.oriya, oriya)
        addIfIncluded(.oromo, oromo)
        addIfIncluded(.ossetian, ossetian)
        addIfIncluded(.pāli, pāli)
        addIfIncluded(.persian, persian)
        addIfIncluded(.polish, polish)
        addIfIncluded(.portuguese, portuguese)
        addIfIncluded(.punjabi, punjabi)
        addIfIncluded(.quechua, quechua)
        addIfIncluded(.romanian, romanian)
        addIfIncluded(.romansh, romansh)
        addIfIncluded(.russian, russian)
        addIfIncluded(.sami, sami)
        addIfIncluded(.samoan, samoan)
        addIfIncluded(.sango, sango)
        addIfIncluded(.sanskrit, sanskrit)
        addIfIncluded(.serbian, serbian)
        addIfIncluded(.serboCroatian, serboCroatian)
        addIfIncluded(.sesotho, sesotho)
        addIfIncluded(.setswana, setswana)
        addIfIncluded(.shona, shona)
        addIfIncluded(.sindhi, sindhi)
        addIfIncluded(.sinhalese, sinhalese)
        addIfIncluded(.slovak, slovak)
        addIfIncluded(.slovenian, slovenian)
        addIfIncluded(.somali, somali)
        addIfIncluded(.southernNdebele, southernNdebele)
        addIfIncluded(.spanish, spanish)
        addIfIncluded(.sundanese, sundanese)
        addIfIncluded(.swahili, swahili)
        addIfIncluded(.swati, swati)
        addIfIncluded(.swedish, swedish)
        addIfIncluded(.tagalog, tagalog)
        addIfIncluded(.tahitian, tahitian)
        addIfIncluded(.tajik, tajik)
        addIfIncluded(.tamil, tamil)
        addIfIncluded(.tatar, tatar)
        addIfIncluded(.telugu, telugu)
        addIfIncluded(.thai, thai)
        addIfIncluded(.tibetan, tibetan)
        addIfIncluded(.tigrinya, tigrinya)
        addIfIncluded(.tonga, tonga)
        addIfIncluded(.tsonga, tsonga)
        addIfIncluded(.turkish, turkish)
        addIfIncluded(.turkmen, turkmen)
        addIfIncluded(.twi, twi)
        addIfIncluded(.ukEnglish, ukEnglish)
        addIfIncluded(.ukrainian, ukrainian)
        addIfIncluded(.urdu, urdu)
        addIfIncluded(.usEnglish, usEnglish)
        addIfIncluded(.uyghur, uyghur)
        addIfIncluded(.uzbek, uzbek)
        addIfIncluded(.venda, venda)
        addIfIncluded(.vietnamese, vietnamese)
        addIfIncluded(.volapük, volapük)
        addIfIncluded(.wallon, wallon)
        addIfIncluded(.welsh, welsh)
        addIfIncluded(.westernFrisian, westernFrisian)
        addIfIncluded(.wolof, wolof)
        addIfIncluded(.xhosa, xhosa)
        addIfIncluded(.yoruba, yoruba)
        addIfIncluded(.zulu, zulu)

        self = .init(default: `default`, dictionary: dictionary)
    }
}
