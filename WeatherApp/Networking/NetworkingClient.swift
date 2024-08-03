import Foundation
import Alamofire

final class NetworkingClient {
    func getRequest<T: Decodable>(from url: URL, as type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: .get)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
