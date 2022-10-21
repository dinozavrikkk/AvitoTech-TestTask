//
//  Alerts.swift
//  AvitoTestTask
//
//  Created by admin on 20.10.2022.
//

import Foundation
import UIKit

enum Alerts {
    static func getAlertNoInternetConnection(_ viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        viewController.present(alert, animated: true)
    }
}
