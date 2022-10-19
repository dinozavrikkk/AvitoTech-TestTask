//
//  EmployeePresenterProtocol.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

protocol EmployeePresenterProtocol: AnyObject {
    var employeeListCount: Int { get }
    func viewIsReady()
    func employee(for indexPath: IndexPath) -> Employee
}
