//
//  PageViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var days: [DayViewController]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self 
    }
    
    func set(days: [DayViewController]) {
        setViewControllers(days, direction: .forward, animated: true, completion: nil)
    }

}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return Router.dayViewController()
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return Router.dayViewController()
    }
    
    func contentViewController(at page: Int) -> DayViewController {
        let dayVC = Router.dayViewController()
        dayVC.page = page
        return Router.dayViewController()
    }
    
}
