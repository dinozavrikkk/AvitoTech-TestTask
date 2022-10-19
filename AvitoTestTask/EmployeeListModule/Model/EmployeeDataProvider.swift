//
//  EmployeeDataProvider.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

final class EmployeeDataProvider {
    private let employeeDataStorage: EmployeeDataStorageProtocol
    private let userDefault = UserDefaults.standard
    
    init(employeeDataStorage: EmployeeDataStorageProtocol) {
        self.employeeDataStorage = employeeDataStorage
    }
}

extension EmployeeDataProvider: EmployeeDataProviderProtocol {
    
    func getData(completion: @escaping (Result<[Employee], Error>) -> Void) {
        let savedDate = userDefault.date(forKey: KeyForUserDefault.savedDate.string) ?? Date()
        if savedDate < Date.now {
            guard let url = URL(string: URLStrings.employeeListURL.url) else { return }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                if let data = data,
                   let company = try? JSONDecoder().decode(EmployeeListModel.self, from: data) {
                    
                    let hour: TimeInterval = 30
                    let date = Date.now.addingTimeInterval(hour)
                    self.userDefault.set(date: date, forKey: KeyForUserDefault.savedDate.string)
                    
                    do {
                        try self.userDefault.setObject(company, forKey: KeyForUserDefault.savedCodableObject.string)
                    } catch {
                        print(error.localizedDescription)
                    }
                    self.employeeDataStorage.fillingEmployeeListWithData(data: company)
                    DispatchQueue.main.async {
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
        } else {
            do {
                let savedObject = try userDefault.getObject(forKey: KeyForUserDefault.savedCodableObject.string, castTo: EmployeeListModel.self)
                self.employeeDataStorage.fillingEmployeeListWithData(data: savedObject)
                DispatchQueue.main.async {
                    completion(.success(self.employeeDataStorage.transmittingEmployeeListArray))
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}


