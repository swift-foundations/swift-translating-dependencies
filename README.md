# swift-translating-dependencies

![Development Status](https://img.shields.io/badge/status-active--development-orange.svg)

The translating × dependencies integration: the `\.language` and `\.languages`
keys and every [swift-translating](https://github.com/swift-foundations/swift-translating)
surface that reads them.

> One home for language as a dependency. The vocabulary types (`Language`,
> `Translated`, `TranslatedString`) live in swift-translating; everything that
> resolves them *through the ambient language context* lives here.

## Overview

`import Translating_Dependencies` provides:

| Surface | Description |
|---------|-------------|
| `@Dependency(\.language)` | The current language (defaults to `.english`) |
| `@Dependency(\.languages)` | The language set for bulk operations (defaults to `Set<Language>.supported`) |
| `Translated: CustomStringConvertible` | `description` resolves via `\.language` |
| `Translated: Comparable` | ordering resolves via `\.language` |
| `Translated.init(english:…)` | the 180-label mass initializer, filtered by `\.languages` |
| `Date.description(dateStyle:timeStyle:)` / `Date.formatted(date:time:translated:)` | language-dependent date formatting |
| `[String].joined(separator:)` / `[TranslatedString].joined(separator:)` | language-dependent list joining |

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-foundations/swift-translating-dependencies.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Translating Dependencies", package: "swift-translating-dependencies")
    ]
)
```

## Quick Start

```swift
import Translating_Dependencies

let greeting: TranslatedString = [.english: "Hello", .dutch: "Hallo"]

withDependencies {
    $0.language = .dutch
} operation: {
    print(greeting)  // "Hallo"
}
```

Limit bulk operations to specific languages:

```swift
withDependencies {
    $0.languages = [.english, .dutch, .french]
} operation: {
    let formatted = Date().formatted(date: .complete, time: .shortened, translated: true)
}
```

## License

Licensed under the [Apache License, Version 2.0](LICENSE.md).
