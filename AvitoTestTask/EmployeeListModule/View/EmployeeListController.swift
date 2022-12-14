//
//  MainScreen.swift
//  AvitoTestTask
//
//  Created by admin on 17.10.2022.
//

import Foundation
import UIKit

final class EmployeeListController: UIViewController {
    
    let mainView = EmployeeListView()
    var employeePresenter: EmployeePresenterProtocol?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizationTableView()
        employeePresenter?.viewIsReady()
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension EmployeeListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employeePresenter?.showTheNumberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellForAnEmployee.identifier, for: indexPath) as? CellForAnEmployee
        else {
            return UITableViewCell()
        }
        if let model = employeePresenter?.showTheEmployee(for: indexPath) {
            cell.updateCell(data: model)
        } else {
            print("Ячейки не заполнились")
        }
        return cell
    }
}

//MARK: EmployeeListControllerProtocol
extension EmployeeListController: EmployeeListControllerProtocol {
    func updateTableView() {
        mainView.listOfEmployeesTableView.reloadData()
    }
    
    func showAlert() {
        Alerts.getAlertNoInternetConnection(self,
                                            title: AlertsTitleText.noInternetConnection.title,
                                            message: AlertsMessageText.noInternetConnection.message)
    }
}

//MARK: CustomizeTableView
private extension EmployeeListController {
    func customizationTableView() {
        mainView.listOfEmployeesTableView.delegate = self
        mainView.listOfEmployeesTableView.dataSource = self
        mainView.listOfEmployeesTableView.register(CellForAnEmployee.self, forCellReuseIdentifier: CellForAnEmployee.identifier)
        mainView.listOfEmployeesTableView.separatorStyle = .none
        mainView.listOfEmployeesTableView.rowHeight = UITableView.automaticDimension
    }
}
