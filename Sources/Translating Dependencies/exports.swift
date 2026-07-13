// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-translating-dependencies open source project
//
// Copyright (c) 2026 Coen ten Thije Boonkkamp and the swift-translating-dependencies
// project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

// Re-exports both halves of the integration so `import Translating_Dependencies`
// is a self-contained surface: the translating vocabulary and the dependency
// system both appear in the vended API.

@_exported public import Dependencies
@_exported public import Language
@_exported public import Translated
@_exported public import Translated_String
