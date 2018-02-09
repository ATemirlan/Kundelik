//
//  PageViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {

    var currentDay = Router.dayViewController(with: Date())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
        setViewControllers([currentDay], direction: .forward, animated: true, completion: nil)
    }

}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate, DayViewProtocol {
    
    func set(current day: DayViewController) {
        currentDay = day
        parent?.title = day.date.toString()
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let yesterday = Router.dayViewController(with: currentDay.date.yesterday)
        yesterday.delegate = self
        return yesterday
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let tomorrow = Router.dayViewController(with: currentDay.date.tomorrow)
        tomorrow.delegate = self
        return tomorrow
    }
    
}
