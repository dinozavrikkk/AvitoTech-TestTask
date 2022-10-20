//
//  EmployeeListDataStorage.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

final class EmployeeListDataStorage {
    
}

extension EmployeeListDataStorage: EmployeeDataStorageProtocol {
    
    func numberOfRowsInSection(employeeListModel: EmployeeListModel) -> Int {
        return employeeListModel.company.employees.count
    }
    
    func getEmployee(employeeListModel: EmployeeListModel, for indexPath: IndexPath) -> Employee {
        return employeeListModel.company.employees.sorted { $0.name < $1.name }[indexPath.row]
    }
}
