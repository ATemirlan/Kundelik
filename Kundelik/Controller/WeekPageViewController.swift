//
//  WeekPageViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/15/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol WeekPageControllerDelegate {
    func newDateSelected(date: Date)
}

class WeekPageViewController: UIPageViewController {

    var currentWeek = Router.weekViewController(with: Date())
    
    var weekDelegate: WeekPageControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        delegate = self
        dataSource = self
        
        setViewControllers([currentWeek], direction: .forward, animated: false, completion: { (compleiton) in
            self.currentWeek.delegate = self
        })
    }
    
    func select(newDate: Date) {
        if newDate.compare(currentWeek.currentDate.weekBefore.endOfWeek!).rawValue == -1 {
            setNewWeek(with: newDate, direction: .reverse)
        } else if currentWeek.currentDate.weekAfter.startOfWeek!.compare(newDate).rawValue == 1 {
            setNewWeek(with: newDate, direction: .forward)
        }
        
        for day in currentWeek.weekdays {
            if newDate.toString() == day.date.toString() {
                currentWeek.unselectAll()
                day.set(selected: true)
            }
        }
    }
    
    func setNewWeek(with date: Date, direction: UIPageViewControllerNavigationDirection) {
        let week = Router.weekViewController(with: date)
        week.delegate = self

        setViewControllers([week], direction: direction, animated: false, completion: { (compleiton) in
            week.delegate = self
        })
    }

}

extension WeekPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate, WeekViewProtocol {
    
    func select(date: Date) {
        weekDelegate?.newDateSelected(date: date)
    }
    
    func set(current week: WeekViewController) {
        currentWeek = week
        weekDelegate?.newDateSelected(date: week.currentDate)
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let weekBefore = Router.weekViewController(with: currentWeek.currentDate.weekBefore)
        weekBefore.delegate = self
        return weekBefore
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let weekAfter = Router.weekViewController(with: currentWeek.currentDate.weekAfter)
        weekAfter.delegate = self
        return weekAfter
    }
    
}
