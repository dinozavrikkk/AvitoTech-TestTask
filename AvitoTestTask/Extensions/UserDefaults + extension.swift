//
//  UserDefaults + extension.swift
//  AvitoTestTask
//
//  Created by admin on 18.10.2022.
//

import Foundation

extension UserDefaults {
    func set(date: Date?, forKey key: String) {
        self.set(date, forKey: key)
    }
    
    func date(forKey key: String) -> Date? {
        return self.value(forKey: key) as? Date
    }
}
