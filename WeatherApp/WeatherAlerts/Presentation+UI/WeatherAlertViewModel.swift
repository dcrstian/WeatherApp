import Foundation

final class WeatherAlertsViewModel {
    var weatherEvents: [WeatherData.WeatherEvent] = []
    private let weatherService: WeatherService
    private let interval: Date? = .now
    
    init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    func fetchWeatherAlerts() async {
        do {
            let weatherData = try await weatherService.fetchWeatherAlerts()
            self.weatherEvents = weatherData.events
        } catch {
            print("Error fetching weather alerts: \(error)")
        }
    }
}

