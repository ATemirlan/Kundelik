//
//  Alert.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/27/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class Alert {
    
    static func showError(textError: String, above vc: UIViewController) {
        let alert = UIAlertController(title: "Ошибка", message: textError, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: { (action) in}))
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(vc: UIViewController, title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for alertAction in actions {
            alert.addAction(alertAction)
        }
        
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func showActionSheet(vc: UIViewController, title: String?, message: String?, actions: [UIAlertAction]) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for action in actions {
            actionSheet.addAction(action)
        }
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
}
