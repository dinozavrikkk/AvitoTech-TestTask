//
//  KeyForUserDefault.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

enum KeyForUserDefault {
    case savedDate
    case savedCodableObject
    
    var string: String {
        switch self {
        case .savedDate:
            return "SavedDate"
        case .savedCodableObject:
            return "SavedCodableObject"
        }
    }
}
