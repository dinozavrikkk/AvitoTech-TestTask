//
//  EmployeePresenterProtocol.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

protocol EmployeePresenterProtocol: AnyObject {
    var showTheNumberOfRows: Int? { get }
    func viewIsReady()
    func showTheEmployee(for indexPath: IndexPath) -> Employee?
}
