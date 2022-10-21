//
//  AvitoTestTaskTests.swift
//  AvitoTestTaskTests
//
//  Created by admin on 20.10.2022.
//

import XCTest
@testable import AvitoTestTask

class EmployeeListPresenterTests: XCTestCase {

    func testThatViewIsReadyCallsDataProviderGetData() throws {
        let dataProvider = DataProviderMock()
        let dataStorage = DataStorageMock()
        let viewController = ViewControllerMock()
        let presenter = EmployeeListPresenter(employeeDataProvider: dataProvider,
                                              employeeDataStorage: dataStorage,
                                              employeeViewController: viewController)
        
        presenter.viewIsReady()
        
        XCTAssertTrue(dataProvider.isGetDataCalled)
    }
    
    func testThatViewIsReadyHandlesSuccessNetworkResult() throws {
        let dataProvider = DataProviderMock()
        let dataStorage = DataStorageMock()
        let viewController = ViewControllerMock()
        let presenter = EmployeeListPresenter(employeeDataProvider: dataProvider,
                                              employeeDataStorage: dataStorage,
                                              employeeViewController: viewController)
        
        dataProvider.result = .success(.init(company: Company(name: "AvitoTest", employees: [])))
        presenter.viewIsReady()
        
        dataProvider.getData(cacheEmployeeListModel: nil) { result in
            switch result {
            case .success(let success):
                XCTAssertEqual(success, .init(company: Company(name: "AvitoTest", employees: [])))
            case .failure(_):
                XCTFail("The result should be success")
            }
        }
    }

    func testThatViewIsReadyHandleSuccessNetworkResultAndCallsUpdateTableView() throws {
        let dataProvider = DataProviderMock()
        let dataStorage = DataStorageMock()
        let viewController = ViewControllerMock()
        let presenter = EmployeeListPresenter(employeeDataProvider: dataProvider,
                                              employeeDataStorage: dataStorage,
                                              employeeViewController: viewController)

        dataProvider.result = .success(.init(company: Company(name: "AvitoTest", employees: [])))
        presenter.viewIsReady()
    
        XCTAssertTrue(viewController.isUpdateTableViewCalled)
    }
    
    func testThatViewIsReadyHandleFailureNetworkResultAndCallsShowAlert() throws {
        let dataProvider = DataProviderMock()
        let dataStorage = DataStorageMock()
        let viewController = ViewControllerMock()
        let presenter = EmployeeListPresenter(employeeDataProvider: dataProvider,
                                              employeeDataStorage: dataStorage,
                                              employeeViewController: viewController)

        dataProvider.result = .failure(TestErrors.noInternetConnection)
        UserDefaultsConfig.defaults.timeTracker = Date.now
        presenter.viewIsReady()

        XCTAssertTrue(viewController.isShowAlertCalled)
    }
    
    func testThatViewIsReadyHandleSuccessCachedObjectAndCallsUpdateTableView() throws {
        let dataProvider = DataProviderMock()
        let dataStorage = DataStorageMock()
        let viewController = ViewControllerMock()
        let presenter = EmployeeListPresenter(employeeDataProvider: dataProvider,
                                              employeeDataStorage: dataStorage,
                                              employeeViewController: viewController)
        
        dataProvider.result = .success(.init(company: Company(name: "AvitoTest", employees: [])))
        let hour: TimeInterval = 60
        let date = Date.now.addingTimeInterval(hour)
        UserDefaultsConfig.defaults.timeTracker = date
        presenter.viewIsReady()
        
        XCTAssertTrue(viewController.isUpdateTableViewCalled)
    }
    
    func testThatShowTheNumberOfRowsHandlesDataStorageIsNumberOfRowsInSection() throws {
        let dataProvider = DataProviderMock()
        let dataStorage = DataStorageMock()
        let viewController = ViewControllerMock()
        let presenter = EmployeeListPresenter(employeeDataProvider: dataProvider,
                                              employeeDataStorage: dataStorage,
                                              employeeViewController: viewController)
        
        presenter.viewIsReady()
        let _ = presenter.showTheNumberOfRows
        
        XCTAssertTrue(dataStorage.isNumberOfRowsInSectionCalled)
    }
}

private final class DataProviderMock: EmployeeDataProviderProtocol {
   
    var isGetDataCalled = false
    var result: Result<EmployeeListModel, Error>?
    
    func getData(cacheEmployeeListModel: EmployeeListModel?, completion: @escaping (Result<EmployeeListModel, Error>) -> Void) {
        isGetDataCalled.toggle()
        completion(result ?? .success(.init(company: Company(name: "Test", employees: []))))
    }
}

private final class DataStorageMock: EmployeeDataStorageProtocol {
    
    var isNumberOfRowsInSectionCalled = false
    var isGetEmployeeCalled = false
    
    func numberOfRowsInSection(employeeListModel: EmployeeListModel) -> Int {
        isNumberOfRowsInSectionCalled.toggle()
        return employeeListModel.company.employees.count
    }
    
    func getEmployee(employeeListModel: EmployeeListModel, for indexPath: IndexPath) -> Employee {
        isGetEmployeeCalled.toggle()
        return employeeListModel.company.employees[indexPath.row]
    }
}

private final class ViewControllerMock: UIViewController, EmployeeListControllerProtocol {

    var isUpdateTableViewCalled = false
    var isShowAlertCalled = false

    func updateTableView() {
        isUpdateTableViewCalled.toggle()
    }

    func showAlert() {
        isShowAlertCalled.toggle()
    }
}

private enum TestErrors: Error {
    case noInternetConnection
}
