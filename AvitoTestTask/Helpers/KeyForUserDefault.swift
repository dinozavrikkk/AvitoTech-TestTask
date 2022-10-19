//
//  KeyForUserDefault.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

enum KeyForUserDefault {
    case savedDateString
    
    var savedString: String {
        switch self {
        case .savedDateString:
            return "SavedDate"
        }
    }
}
