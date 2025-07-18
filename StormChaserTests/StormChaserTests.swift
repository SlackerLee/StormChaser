//
//  StormChaserTests.swift
//  StormChaserTests
//
//  Created by Tung on 16/7/2025.
//

import Testing
import Foundation
@testable import StormChaser

struct StormChaserTests {

    @Test func example() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    }

    @Test
    func testFetchWeatherForecastReturnsData() async throws {
        var result: [WeatherData]? = nil
        let semaphore = DispatchSemaphore(value: 0)

        ForecastManager.shared.fetchWeatherForecast(latitude: 40.7128, longitude: -74.0060) { data in
            result = data
            semaphore.signal()
        }

        // Wait for completion with timeout
        let timeoutResult = semaphore.wait(timeout: .now() + 10.0)
        #expect(timeoutResult == .success, "Test timed out waiting for weather data")
        #expect(result != nil, "Expected non-nil weather data")
        #expect(result?.count ?? 0 > 0, "Expected at least one weather data entry")
    }

}
