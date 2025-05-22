//
//  DNetworkManager.swift
//  Disvigo
//
//  Created by abdullah on 21.05.2025.
//

import Foundation



final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    func fetchData<T: Decodable>(path: EndpointPath) async throws -> T {
        guard let url = Endpoint(path: path).url else {
            throw NetworkError.badURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            if let res = response as? HTTPURLResponse {
                print(res.statusCode.description)
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  200 ..< 300 ~= httpResponse.statusCode
            else {
                throw NetworkError.invalidResponse
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingFailed
            }
        } catch {
            throw NetworkError.requestFailed
        }
    }

}
