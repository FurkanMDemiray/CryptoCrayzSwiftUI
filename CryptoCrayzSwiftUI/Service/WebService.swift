//
//  WebService.swift
//  CryptoCrayzSwiftUI
//
//  Created by Melik Demiray on 31.12.2023.
//

import Foundation


enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
    case badResponse
}

class WebService {

    func downloadCurreciensAsync(url: URL) async throws -> [Crypto] {

        let (data, _) = try await URLSession.shared.data(from: url)

        if let cryptos = try? JSONDecoder().decode([Crypto].self, from: data) {
            return cryptos
        } else {
            return []
        }
    }


    func downloadCurreciens(url: URL, completion: @escaping (Result<[Crypto], NetworkError>) -> Void) {

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error {
                completion(.failure(.badUrl))
                print(error.localizedDescription)
            }

            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }

            guard let currencies = try? JSONDecoder().decode([Crypto].self, from: data) else {
                return completion(.failure(.decodingError))
            }
            completion(.success(currencies))

        }.resume()
    }
}
