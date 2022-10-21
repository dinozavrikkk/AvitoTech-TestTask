//
//  AlertsTitleText.swift
//  AvitoTestTask
//
//  Created by admin on 20.10.2022.
//

import Foundation

enum AlertsTitleText {
    case noInternetConnection
    
    var title: String {
        switch self {
        case .noInternetConnection:
            return "No internet connection"
        }
    }
}
