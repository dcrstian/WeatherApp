import Foundation

final class WeatherHTTPService: WeatherService {
    private let url = URL(string: "https://api.weather.gov/alerts/active?status=actual&message_type=alert")!
    private let networkClient: NetworkingClient
    
    init(networkClient: NetworkingClient) {
        self.networkClient = networkClient
    }
    
    func fetchWeatherAlerts() async throws -> WeatherData {
        let weatherDTO: WeatherDTO = try await networkClient.getRequest(from: url, as: WeatherDTO.self)
        return weatherDTO.toDomainModel()
    }
}
