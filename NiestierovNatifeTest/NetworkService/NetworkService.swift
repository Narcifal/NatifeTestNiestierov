//
//  PostListManager.swift
//  NiestierovNatifeTest
//
//  Created by Denys Niestierov on 22.07.2022.
//

import Foundation

class NetworkService {
    //MARK: - Static -
    static let shared = NetworkService()
    
    //MARK: - Internal -
    func getData<T: Codable>(url: URL, expecting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetworkingError.failedResponseJSON))
                return
            }
            if let post = self.parseJson(data, expacting: expecting) {
                completion(.success(post))
            } else {
                completion(.failure(NetworkingError.failedParseJSON))
            }
        }.resume()
    }
    
    //MARK: - Private -
    private func parseJson<T: Codable>(_ data: Data, expacting: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodateData = try decoder.decode(expacting, from: data)
            return decodateData
        } catch {
            return nil
        }
    }
    
    private enum NetworkingError: Error {
        case failedResponseJSON
        case failedParseJSON
    }
}
