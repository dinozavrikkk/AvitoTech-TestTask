//
//  DataDecoderProtocol.swift
//  AvitoTestTask
//
//  Created by admin on 20.10.2022.
//

import Foundation

protocol DataDecoderProtocol: AnyObject {
    func decodeJSON<T: Codable>(type: T.Type, data: Data?) -> T?
}

class DataDecoder: DataDecoderProtocol {
    
    func decodeJSON<T: Codable>(type: T.Type, data: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = data else { return nil }
        do {
            let objects = try decoder.decode(type, from: data)
            return objects
        } catch {
            return nil
        }
    }
}
