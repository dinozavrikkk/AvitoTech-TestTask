//
//  EmployeeListPresenter.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

final class EmployeeListPresenter {
    
    private let employeeDataProvider: EmployeeDataProviderProtocol
    private let employeeDataStorage: EmployeeDataStorageProtocol
    private var employeeListModel: EmployeeListModel?
    private weak var employeeViewController: EmployeeListControllerProtocol?
    
    init(employeeDataProvider: EmployeeDataProviderProtocol,
         employeeDataStorage: EmployeeDataStorageProtocol,
         employeeViewController: EmployeeListControllerProtocol?) {
        self.employeeDataProvider = employeeDataProvider
        self.employeeViewController = employeeViewController
        self.employeeDataStorage = employeeDataStorage
    }
}

extension EmployeeListPresenter: EmployeePresenterProtocol {
    
    func viewIsReady() {
        let timeTracker = UserDefaultsConfig.defaults.timeTracker
        if timeTracker < Date.now {
            employeeDataProvider.getData(cacheEmployeeListModel: nil) { [weak self] result in
                switch result {
                case .success(let model):
                    let hour: TimeInterval = 3600
                    let date = Date.now.addingTimeInterval(hour)
                    UserDefaultsConfig.defaults.timeTracker = date
                    UserDefaultsConfig.defaults.cacheEmployee = model
                    self?.employeeListModel = model
                    self?.employeeViewController?.updateTableView()
                case .failure:
                    self?.employeeViewController?.showAlert()
                }
            }
        } else {
            let cacheEmployee = UserDefaultsConfig.defaults.cacheEmployee
            employeeDataProvider.getData(cacheEmployeeListModel: cacheEmployee) { [weak self] result in
                switch result {
                case .success(let model):
                    self?.employeeListModel = model
                    self?.employeeViewController?.updateTableView()
                case .failure:
                    assertionFailure()
                }
            }
        }
    }
    
    var showTheNumberOfRows: Int? {
        guard let model = employeeListModel else { return nil }
        return employeeDataStorage.numberOfRowsInSection(employeeListModel: model)
    }
    
    func showTheEmployee(for indexPath: IndexPath) -> Employee? {
        guard let model = employeeListModel else { return nil }
        return employeeDataStorage.getEmployee(employeeListModel: model, for: indexPath)
    }
}
