//
//  NetworkDataFetcher.swift
//  AvitoTestTask
//
//  Created by admin on 20.10.2022.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private let dataDecoder: DataDecoderProtocol
    
    init(dataDecoder: DataDecoderProtocol) {
        self.dataDecoder = dataDecoder
    }
    
    func request<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTast(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTast<T: Codable>(from request: URLRequest, completion: @escaping (Result<T, Error>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, _, error in
            if let object = self.dataDecoder.decodeJSON(type: T.self, data: data) {
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } else {
                guard let error = error else { return }
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }
    }
}


