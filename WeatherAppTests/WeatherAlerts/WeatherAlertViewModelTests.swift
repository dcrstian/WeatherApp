import Foundation
import XCTest
@testable import WeatherApp

final class WeatherAlertViewModelTests: XCTest {
    func testFetchWeatherAlertsFailure() async throws {
        // Given
        let expectedError = NSError(domain: "com.example", code: 1, userInfo: nil)
        let sut = makeSUT(fetchWeatherAlertsResult: .failure(expectedError))
        
        // When
        await sut.fetchWeatherAlerts()
        
        // Then
        XCTAssertEqual(sut.weatherEvents, mockWeatherData.events)
        //            XCTAssertEqual(s.error as NSError?, expectedError, "Error should match the expected error")
    }
    // MARK: - Helpers
    
    private func makeSUT(
        fetchWeatherAlertsResult: Result<WeatherData, Error> = .success(WeatherData(events: []))
    ) -> WeatherAlertsViewModel {
        WeatherAlertsViewModel(weatherService: MockWeatherService(fetchWeatherAlertsResult: fetchWeatherAlertsResult))
    }
    
    private let mockWeatherData = WeatherData(events: [WeatherData.WeatherEvent(event: "Event name",
                                                                                startDate: "startDate",
                                                                                endDate: "endDate",
                                                                                source: "source")])
}


