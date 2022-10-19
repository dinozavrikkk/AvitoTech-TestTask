//
//  URLStrings.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

enum URLStrings {
    case employeeListURL
    
    var url: String {
        switch self {
        case .employeeListURL:
            return "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        }
    }
}
