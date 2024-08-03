import Foundation
import Alamofire

enum WeatherDataError: Error {
    case invalidServerResponse
}

class WeatherHTTPService: WeatherService {
    private let url = URL(string: "https://api.weather.gov/alerts/active?status=actual&message_type=alert")!
    func fetchWeatherAlerts() async throws -> WeatherData {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get)
                .validate()
                .responseDecodable(of: WeatherDTO.self) { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data.toDomainModel())
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
