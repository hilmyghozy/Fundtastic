//
//  NetworkManager.swift
//  Fundtastic
//
//  Created by hilmy ghozy on 06/12/21.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<NetworkAPI> { get }
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<NetworkAPI>(plugins: [NetworkLoggerPlugin()])
    
    func requestItems(parameter: String, completion: @escaping (Result<apiResponse<CategoryModel>, Error>) -> ()) {
        request(target: .getCategory(parameter: parameter), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: NetworkAPI, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                   
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
