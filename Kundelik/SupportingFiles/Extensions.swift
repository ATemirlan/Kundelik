//
//  Extensions.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static var segueID:String {
        return className
    }
    
    func setEmptyBackButton(){
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        tabBarController?.navigationItem.backBarButtonItem = backItem
        navigationController?.navigationBar.tintColor = .white //UIColor().backItemColor
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc func hideKeyBoard(){
        view.endEditing(true)
    }

}

extension UITableViewCell {
    
    static var cellID: String {
        return className
    }
    
    static var nibName: String {
        return className
    }
    
}

extension NSObject {
    
    var className: String {
        return type(of: self).className
    }
    
    static var className: String {
        return String(describing: self)
    }
}

