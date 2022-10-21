//
//  AlertsText.swift
//  AvitoTestTask
//
//  Created by admin on 20.10.2022.
//

import Foundation

enum AlertsMessageText {
    case noInternetConnection
    
    var message: String {
        switch self {
        case .noInternetConnection:
            return "Check your internet connection and restart the app"
        }
    }
}
