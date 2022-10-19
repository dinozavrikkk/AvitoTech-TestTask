//
//  EmployeeListPresenter.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

final class EmployeeListPresenter {
    
    private let employeeDataProvider: EmployeeDataProviderProtocol
    private let employeeDataStorage: EmployeeListDataStorage
    private weak var employeeViewController: EmployeeListControllerProtocol?
    
    init(employeeDataProvider: EmployeeDataProviderProtocol,
         employeeDataStorage: EmployeeListDataStorage,
         employeeViewController: EmployeeListControllerProtocol?) {
        self.employeeDataProvider = employeeDataProvider
        self.employeeViewController = employeeViewController
        self.employeeDataStorage = employeeDataStorage
    }
}

extension EmployeeListPresenter: EmployeePresenterProtocol {
    func viewIsReady() {
        employeeDataProvider.getData { [weak self] _ in
            self?.employeeViewController?.fetchModel()
        }
    }
    
    var employeeListCount: Int {
        employeeDataStorage.numberOfRowsInSection
    }
    
    func employee(for indexPath: IndexPath) -> Employee {
        employeeDataStorage.getEmployee(for: indexPath)
    }
}
