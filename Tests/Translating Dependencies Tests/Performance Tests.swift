//
//  Performance Tests.swift
//  swift-translating-dependencies
//
//  Created by Coen ten Thije Boonkkamp on 25/07/2025.
//

import Dependencies
import Dependencies_Test_Support
import Foundation
import Testing

import Language
import Translated
import Translated_String

@testable import Translating_Dependencies

#if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
    import Darwin
#endif

@Suite(
    "Performance Tests",
    .serialized,
    .disabled("Enable for performance testing")
)
struct Performance {

    @Suite(
        .serialized
    )
    struct `Closure Based Initialization` {

        @Test
        func `All languages dependency - Current Implementation`() throws {
            let clock = ContinuousClock()
            var callCount = 0

            let languages = Array(Set<Language>.supported)

            let result = clock.measure {
                withDependencies {
                    $0.languages = Set(languages)  // All 179 languages
                } operation: {
                    let translated = Translated<String> { language in
                        callCount += 1
                        return "Translation for \(language)"
                    }
                    _ = translated[.english]  // Access one value to ensure initialization
                }
            }

            let timeInSeconds =
                Double(result.components.seconds) + Double(result.components.attoseconds) / 1e18
            print("📊 PERFORMANCE DATA - Closure Initializer (All Languages):")
            print("   Time: \(result)")
            print("   Time (seconds): \(timeInSeconds)")
            print("   Closure calls: \(callCount)")
            print("   Languages in dependency: \(Set<Language>.supported.count)")
            print("   Calls per second: \(Double(callCount) / timeInSeconds)")
            print("   Average time per closure call: \(timeInSeconds / Double(callCount) * 1000)ms")
            print("   ⚠️  Performance issue: Closure called \(callCount) times for ALL languages!")

            // This should demonstrate the performance problem
            #expect(
                callCount == languages.count + 1,
                "Current implementation calls closure for ALL languages"
            )
            #expect(
                result < .seconds(0.5),
                "Should complete within reasonable time even with inefficiency"
            )
        }

        @Test
        func `Limited languages dependency`() throws {
            let limitedLanguages: Set<Language> = [.english, .dutch, .french, .german, .spanish]
            let clock = ContinuousClock()
            var callCount = 0

            let result = clock.measure {
                withDependencies {
                    $0.languages = limitedLanguages
                } operation: {
                    let translated = Translated<String> { language in
                        callCount += 1
                        return "Translation for \(language)"
                    }
                    _ = translated[.english]
                }
            }

            let timeInSeconds =
                Double(result.components.seconds) + Double(result.components.attoseconds) / 1e18
            print("📊 PERFORMANCE DATA - Closure Initializer (Limited Languages):")
            print("   Time: \(result)")
            print("   Time (seconds): \(timeInSeconds)")
            print("   Closure calls: \(callCount)")
            print("   Languages in dependency: \(limitedLanguages.count)")
            print("   Calls per second: \(Double(callCount) / timeInSeconds)")
            print("   Average time per closure call: \(timeInSeconds / Double(callCount) * 1000)ms")
            print("   ✅ Better performance with limited languages")

            #expect(
                callCount == limitedLanguages.count + 1,
                "Should only call closure for languages in dependency"
            )
            #expect(result < .milliseconds(50), "Should be very fast with limited languages")
        }

        @Test
        func `Expensive closure operations - Real-world impact simulation`() throws {
            let clock = ContinuousClock()
            var callCount = 0
            let languages = Array(Set<Language>.supported).prefix(50)

            let result = clock.measure {
                withDependencies {
                    $0.languages = Set(languages)  // First 50 languages
                } operation: {
                    let translated = Translated<String> { language in
                        callCount += 1
                        // Simulate expensive operation (database lookup, API call, complex formatting)
                        Thread.sleep(forTimeInterval: 0.001)  // 1ms delay per call
                        return "Expensive translation for \(language)"
                    }
                    _ = translated[.english]
                }
            }

            let timeInSeconds =
                Double(result.components.seconds) + Double(result.components.attoseconds) / 1e18
            print("📊 PERFORMANCE DATA - Expensive Closure Operations:")
            print("   Time: \(result)")
            print("   Time (seconds): \(timeInSeconds)")
            print("   Closure calls: \(callCount)")
            print("   Simulated delay per call: 1ms")
            print("   Expected minimum time: \(callCount)ms")
            print("   Actual time: \(timeInSeconds * 1000)ms")
            print(
                "   ⚠️  This demonstrates why calling expensive closures 179 times is problematic!"
            )

            #expect(callCount == languages.count + 1, "Should call closure 50 times")
            // With 1ms delay per call, 50 calls should take at least 50ms
            #expect(
                result > Duration.milliseconds(45),
                "Should take significant time due to expensive operations"
            )
        }

        @Test
        func `Real-world scenario - Creating many TranslatedStrings`() throws {
            let stringCount = 1000
            let clock = ContinuousClock()

            let result = clock.measure {
                withDependencies {
                    // Realistic subset
                    $0.languages = Set(Array(Set<Language>.supported).prefix(20))
                } operation: {
                    var translatedStrings: [Translated<String>] = []
                    translatedStrings.reserveCapacity(stringCount)

                    for i in 1...stringCount {
                        let translated = Translated<String> { language in
                            "String \(i) in \(language)"
                        }
                        translatedStrings.append(translated)
                    }

                    // Access a few to ensure they're properly initialized
                    _ = translatedStrings[0][.english]
                    _ = translatedStrings[stringCount / 2][.dutch]
                    _ = translatedStrings[stringCount - 1][.french]
                }
            }

            let timeInSeconds =
                Double(result.components.seconds) + Double(result.components.attoseconds) / 1e18
            print("📊 PERFORMANCE DATA - Real-world Scenario (\(stringCount) TranslatedStrings):")
            print("   Time: \(result)")
            print("   Time (seconds): \(timeInSeconds)")
            print("   Strings created: \(stringCount)")
            print("   Languages per string: 20")
            print("   Total closure calls: \(stringCount * 20)")
            print("   Strings per second: \(Double(stringCount) / timeInSeconds)")
            print("   Average time per string: \(timeInSeconds / Double(stringCount) * 1000)ms")
            print("   ⚠️  Performance scales poorly with language count!")

            #expect(result < .seconds(5), "Should complete within reasonable time")
        }
    }

    @Suite(
        .serialized
    )
    struct `Dictionary Vs Closure` {

        @Test
        func `Dictionary literal initialization performance`() throws {
            let clock = ContinuousClock()

            let result = clock.measure {
                // This should be much faster as it doesn't call any expensive closures
                let translated: Translated<String> = [
                    .english: "Hello",
                    .dutch: "Hallo",
                    .french: "Bonjour",
                    .german: "Hallo",
                    .spanish: "Hola",
                ]
                _ = translated[.english]
            }

            let timeInSeconds =
                Double(result.components.seconds) + Double(result.components.attoseconds) / 1e18
            print("📊 PERFORMANCE DATA - Dictionary Literal Initialization:")
            print("   Time: \(result)")
            print("   Time (seconds): \(timeInSeconds)")
            print("   Languages provided: 5")
            print("   ✅ No closure calls - direct dictionary construction")
            print("   ✅ Performance independent of languages dependency size")

            #expect(result < .milliseconds(10), "Dictionary literal should be extremely fast")
        }

        @Test
        func `Direct comparison - Closure vs Dictionary literal`() throws {
            let testLanguages: Set<Language> = [.english, .dutch, .french, .german, .spanish]

            // Test closure-based approach
            var closureCallCount = 0
            let closureResult = ContinuousClock().measure {
                withDependencies {
                    $0.languages = testLanguages
                } operation: {
                    let translated = Translated<String> { language in
                        closureCallCount += 1
                        return "Translation for \(language)"
                    }
                    _ = translated[.english]
                }
            }

            // Test dictionary literal approach
            let dictionaryResult = ContinuousClock().measure {
                let translated: Translated<String> = [
                    .english: "Translation for en",
                    .dutch: "Translation for nl",
                    .french: "Translation for fr",
                    .german: "Translation for de",
                    .spanish: "Translation for es",
                ]
                _ = translated[.english]
            }

            let closureTimeInSeconds =
                Double(closureResult.components.seconds) + Double(
                    closureResult.components.attoseconds
                )
                / 1e18
            let dictionaryTimeInSeconds =
                Double(dictionaryResult.components.seconds) + Double(
                    dictionaryResult.components.attoseconds
                ) / 1e18
            let performanceRatio = closureTimeInSeconds / dictionaryTimeInSeconds

            print("📊 PERFORMANCE COMPARISON - Closure vs Dictionary:")
            print("   Closure Time: \(closureResult)")
            print("   Closure Time (seconds): \(closureTimeInSeconds)")
            print("   Closure calls: \(closureCallCount)")
            print("   Dictionary Time: \(dictionaryResult)")
            print("   Dictionary Time (seconds): \(dictionaryTimeInSeconds)")
            print("   Performance ratio: \(String(format: "%.2f", performanceRatio))x")
            print("   Dictionary is \(String(format: "%.2f", performanceRatio))x faster")

            #expect(
                closureCallCount == testLanguages.count + 1,
                "Closure approach calls closure for each language"
            )
            #expect(
                dictionaryTimeInSeconds < closureTimeInSeconds,
                "Dictionary literal should be faster"
            )
        }
    }

    @Suite(
        .serialized
    )
    struct `Memory Usage` {

        @Test
        func `Memory comparison - All languages vs Limited languages`() throws {
            let initialMemory = Self.getMemoryUsage()

            // Test with all languages
            var allLanguagesTranslated: Translated<String>?
            let allLanguagesMemoryResult = ContinuousClock().measure {
                withDependencies {
                    $0.languages = Set(Array(Set<Language>.supported))
                } operation: {
                    allLanguagesTranslated = Translated<String> { language in
                        "Translation for \(language)"
                    }
                }
            }
            let allLanguagesMemory = Self.getMemoryUsage()

            // Clear reference
            allLanguagesTranslated = nil

            // Test with limited languages
            var limitedLanguagesTranslated: Translated<String>?
            let limitedLanguagesMemoryResult = ContinuousClock().measure {
                withDependencies {
                    $0.languages = [.english, .dutch, .french, .german, .spanish]
                } operation: {
                    limitedLanguagesTranslated = Translated<String> { language in
                        "Translation for \(language)"
                    }
                }
            }
            let limitedLanguagesMemory = Self.getMemoryUsage()

            let allLanguagesMemoryIncrease = allLanguagesMemory - initialMemory
            let limitedLanguagesMemoryIncrease = limitedLanguagesMemory - allLanguagesMemory

            print("📊 MEMORY USAGE COMPARISON:")
            print("   Initial memory: \(initialMemory / 1024 / 1024)MB")
            print("   All languages memory: \(allLanguagesMemory / 1024 / 1024)MB")
            print("   Limited languages memory: \(limitedLanguagesMemory / 1024 / 1024)MB")
            print("   All languages increase: \(allLanguagesMemoryIncrease / 1024)KB")
            print("   Limited languages increase: \(limitedLanguagesMemoryIncrease / 1024)KB")
            print("   All languages time: \(allLanguagesMemoryResult)")
            print("   Limited languages time: \(limitedLanguagesMemoryResult)")
            print(
                "   Memory per language (all): \(allLanguagesMemoryIncrease / Int64(Set<Language>.supported.count)) bytes"
            )
            print("   Memory per language (limited): \(limitedLanguagesMemoryIncrease / 5) bytes")

            // Clean up
            limitedLanguagesTranslated = nil

        }

        // MARK: - Helper Functions

        private static func getMemoryUsage() -> Int64 {
            #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
                var info = mach_task_basic_info_data_t()
                var count = mach_msg_type_number_t(
                    MemoryLayout<mach_task_basic_info_data_t>.size / MemoryLayout<integer_t>.size
                )

                let kerr = withUnsafeMutablePointer(to: &info) {
                    $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                        task_info(
                            mach_task_self_,
                            task_flavor_t(MACH_TASK_BASIC_INFO),
                            $0,
                            &count
                        )
                    }
                }

                return kerr == KERN_SUCCESS ? Int64(info.resident_size) : 0
            #else
                return 0
            #endif
        }
    }
}
