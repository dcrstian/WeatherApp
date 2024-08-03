import Foundation
import XCTest
@testable import WeatherApp

final class MockWeatherService: WeatherService {
    private let fetchWeatherAlertsResult: Result<WeatherData, Error>
    
    init(fetchWeatherAlertsResult: Result<WeatherData, Error>) {
        self.fetchWeatherAlertsResult = fetchWeatherAlertsResult
    }
    
    func fetchWeatherAlerts() async throws -> WeatherData {
        return try fetchWeatherAlertsResult.get()
    }
}
