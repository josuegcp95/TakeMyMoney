//
//  Alert.swift
//  TakeMyMoney
//
//  Created by Josue Cruz on 3/10/22.
//

import UIKit

struct Alert {
    
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(alert, animated: true)
    }
}
