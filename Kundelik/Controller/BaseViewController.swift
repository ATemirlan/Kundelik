//
//  BaseViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
    }
    
    func setupPageViewController() {
        let pageViewController = Router.pageViewController(with: getDays(), frame: view.frame)
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
    }
    
    func getDays() -> [DayViewController] {
        var days = [DayViewController]()
        
        for i in 0...6 {
            let day = Router.dayViewController()
            day.page = i
            days.append(day)
        }
        
        return days
    }
    
}
