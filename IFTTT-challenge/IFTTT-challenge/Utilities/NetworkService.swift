//
//  NetworkService.swift
//  IFTTT-challenge
//
//  Created by Andrew Porter on 5/12/23.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidResourcePath
    case fileLoadError
}

protocol NetworkServiceType {
    func fetch<T: Decodable>(_ resource: String, bundle: Bundle) ->  AnyPublisher<T, Error>
}

struct NetworkService: NetworkServiceType {
    
    func fetch<T>(_ resource: String, bundle: Bundle = .main) -> AnyPublisher<T, Error> where T : Decodable {
        Future { promise in
            DispatchQueue.global().async {
                guard let url = bundle.url(forResource: resource, withExtension: "json") else {
                    return promise(.failure(NetworkError.invalidResourcePath))
                }
                
                guard let data = try? Data(contentsOf: url) else {
                    return promise(.failure(NetworkError.fileLoadError))
                }
                
                let decoder = JSONDecoder()
                do {
                    let loaded = try decoder.decode(T.self, from: data)
                    promise(.success(loaded))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
