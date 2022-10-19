//
//  EmployeeDataProvider.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

final class EmployeeDataProvider {
    private let networkDataFetcher = NetworkDataFetcher()
    private let employeeDataStorage: EmployeeDataStorageProtocol
    
    init(employeeDataStorage: EmployeeDataStorageProtocol) {
        self.employeeDataStorage = employeeDataStorage
    }
}

extension EmployeeDataProvider: EmployeeDataProviderProtocol {
    
    func getData(completion: @escaping (Result<[Employee], Error>) -> Void) {
        guard let url = URL(string: URLStrings.employeeListURL.url) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data,
               let company = try? JSONDecoder().decode(EmployeeListModel.self, from: data) {
                DispatchQueue.main.async {
                    self.employeeDataStorage.fillingEmployeeListWithData(data: company)
                    completion(.success(self.employeeDataStorage.transmittingEmployeeListArray))
                }
            }
            else {
                guard let error = error else { return }
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


