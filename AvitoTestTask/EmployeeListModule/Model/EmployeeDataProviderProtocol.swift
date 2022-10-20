//
//  EmployeeDataProviderProtocol.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

protocol EmployeeDataProviderProtocol: AnyObject {
    func getData(cacheEmployeeListModel: EmployeeListModel?, completion: @escaping (Result<EmployeeListModel, Error>) -> Void)
}
