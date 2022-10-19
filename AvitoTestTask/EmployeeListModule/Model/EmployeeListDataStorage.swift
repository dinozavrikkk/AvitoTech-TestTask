//
//  EmployeeListDataStorage.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

final class EmployeeListDataStorage {
    
    private var resultEmployeeList: [Employee] = []
}

extension EmployeeListDataStorage: EmployeeDataStorageProtocol {
    var transmittingEmployeeListArray: [Employee] {
        return resultEmployeeList
    }
    
    var numberOfRowsInSection: Int {
        return resultEmployeeList.count
    }
    
    func fillingEmployeeListWithData(data: EmployeeListModel) {
        return resultEmployeeList += data.company.employees.sorted { $0.name < $1.name }
    }
    
    func getEmployee(for indexPath: IndexPath) -> Employee {
        return resultEmployeeList[indexPath.row]
    }
}
