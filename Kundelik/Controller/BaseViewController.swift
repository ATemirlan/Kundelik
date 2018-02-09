//
//  BaseViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var weekdays: [Weekday]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Date().toString()
        
        setupDaysViewController()
    }
    
    func setupDaysViewController() {
        let pageViewController = Router.pageViewController(with: contentView.frame)
        addChildViewController(pageViewController)
        contentView.addSubview(pageViewController.view)
    }

    
    
}
