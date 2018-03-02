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
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.isTranslucent = true
    }
    
    func showSpinner(deadline: Double, completion: @escaping () -> Void) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let dimView = UIView(frame: window.frame)
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        
        let spinnerView = UIView(frame: CGRect(x: dimView.center.x - 16.0, y: dimView.center.y - 16.0, width: 64.0, height: 64.0))
        spinnerView.layer.cornerRadius = 8.0
        spinnerView.backgroundColor = .white
        
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 64.0, height: 64.0))
        spinner.activityIndicatorViewStyle = .gray
        
        spinnerView.addSubview(spinner)
        dimView.addSubview(spinnerView)
        window.addSubview(dimView)
        spinner.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline) {
            dimView.removeFromSuperview()
            completion()
        }
    }
    
    @objc func hideKeyBoard(){
        view.endEditing(true)
    }
    
    func backViewController() -> UIViewController? {
        if let stack = self.navigationController?.viewControllers {
            for i in (1..<stack.count).reversed() {
                if stack[i] == self {
                    return stack[i-1]
                }
            }
        }
        
        return nil
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

extension UICollectionViewCell {
    
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

