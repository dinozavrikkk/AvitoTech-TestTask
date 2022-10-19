//
//  EmployeeDataStorageProtocol.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

protocol EmployeeDataStorageProtocol: AnyObject {
    var transmittingEmployeeListArray: [Employee] { get }
    var numberOfRowsInSection: Int { get }
    func fillingEmployeeListWithData(data: EmployeeListModel)
    func getEmployee(for indexPath: IndexPath) -> Employee
}
