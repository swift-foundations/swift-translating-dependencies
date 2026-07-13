// swift-tools-version: 6.3.3

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

import PackageDescription

let package = Package(
    name: "swift-translating-dependencies",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        // The translating × dependencies integration: the \.language and
        // \.languages keys, the language-dependent Translated conformances and
        // mass initializers, and the language-dependent Date formatting surface.
        .library(
            name: "Translating Dependencies",
            targets: ["Translating Dependencies"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-foundations/swift-translating.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-dependencies.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "Translating Dependencies",
            dependencies: [
                .product(name: "Language", package: "swift-translating"),
                .product(name: "Translated", package: "swift-translating"),
                .product(name: "Translated String", package: "swift-translating"),
                .product(name: "Translating Platform", package: "swift-translating"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .testTarget(
            name: "Translating Dependencies Tests",
            dependencies: [
                "Translating Dependencies",
                .product(name: "Single Plural", package: "swift-translating"),
                .product(name: "Translating", package: "swift-translating"),
                .product(name: "Dependencies Test Support", package: "swift-dependencies"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
