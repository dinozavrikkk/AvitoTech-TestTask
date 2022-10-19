//
//  EmployeeDataProviderProtocol.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

protocol EmployeeDataProviderProtocol: AnyObject {
    func getData(completion: @escaping (Result<[Employee], Error>) -> Void)
}
