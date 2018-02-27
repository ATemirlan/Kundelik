//
//  PageViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol DayPageControllerDelegate {
    func pageChanged(date: Date)
}

class DayPageViewController: UIPageViewController {

    var date: Date!
    var currentDay: DayViewController!
    var dayDelegate: DayPageControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if currentDay == nil {
            setup()
        }
    }
    
    func setup() {
        delegate = self
        dataSource = self
        
        currentDay = Router.dayViewController(with: date)
        
        setViewControllers([currentDay], direction: .forward, animated: false, completion: { (compleiton) in
            self.currentDay.delegate = self
        })
    }

}

extension DayPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate, DayViewProtocol {
    
    func set(current day: DayViewController) {
        currentDay = day
        parent?.title = day.date.toString()
        dayDelegate?.pageChanged(date: day.date)
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
