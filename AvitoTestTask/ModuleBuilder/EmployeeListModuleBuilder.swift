//
//  MainModuleBuilder.swift
//  AvitoTestTask
//
//  Created by admin on 17.10.2022.
//

import Foundation
import UIKit

enum EmployeeListModuleBuilder {
    static func assemblyMainController() -> UIViewController {
        let employeeListDataStorage = EmployeeListDataStorage()
        let dataDecoder = DataDecoder()
        let networkService = NetworkService(dataDecoder: dataDecoder)
        let employeeListDataProvider = EmployeeDataProvider(networkService: networkService)
        let employeeListVC = EmployeeListController()
        let employeeListPresenter = EmployeeListPresenter(employeeDataProvider: employeeListDataProvider,
                                                          employeeDataStorage: employeeListDataStorage,
                                                          employeeViewController: employeeListVC)
        
        employeeListVC.employeePresenter = employeeListPresenter
        
        return employeeListVC
    }
}
