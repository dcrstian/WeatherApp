protocol WeatherService {
    func fetchWeatherAlerts() async throws -> WeatherData
}
