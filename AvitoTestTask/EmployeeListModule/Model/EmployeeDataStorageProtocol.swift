//
//  EmployeeDataStorageProtocol.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

protocol EmployeeDataStorageProtocol: AnyObject {
    func numberOfRowsInSection(employeeListModel: EmployeeListModel) -> Int
    func getEmployee(employeeListModel: EmployeeListModel, for indexPath: IndexPath) -> Employee
}
