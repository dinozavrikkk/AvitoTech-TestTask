//
//  EmployeeDataProvider.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

final class EmployeeDataProvider {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
}

extension EmployeeDataProvider: EmployeeDataProviderProtocol {
    
    func getData(cacheEmployeeListModel cacheEmployee: EmployeeListModel?, completion: @escaping (Result<EmployeeListModel, Error>) -> Void) {
        guard let cacheEmployee = cacheEmployee else {
            networkService.request(urlString: URLStrings.employeeListURL.url, completion: completion)
            return
        }
        DispatchQueue.main.async {
            completion(.success(cacheEmployee))
        }
    }
}


