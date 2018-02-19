//
//  BaseViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, WeekPageControllerDelegate, DayPageControllerDelegate {

    @IBOutlet weak var dayContainer: UIView!
    @IBOutlet weak var weekContainer: UIView!
    
    var dayPageViewController: DayPageViewController!
    var weekPageViewController: WeekPageViewController!
    
    var choosedDate: Date! = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupWeekViewController()
        setupDaysViewController()
    }
    
    func setupNavigationController() {
        title = choosedDate.toString()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupDaysViewController() {
        dayPageViewController = Router.dayPageViewController(with: dayContainer.frame)
        dayPageViewController.dayDelegate = self
        addChildViewController(dayPageViewController)
        dayContainer.addSubview(dayPageViewController.view)
    }
    
    func setupWeekViewController() {
        weekPageViewController = Router.weekPageViewController(with: weekContainer.frame)
        weekPageViewController.weekDelegate = self
        addChildViewController(weekPageViewController)
        weekContainer.addSubview(weekPageViewController.view)
    }
   
    // MARK: - Week and Day Delegates
    
    func newDateSelected(date: Date) {
        changeDay(date: date)
    }
    
    func pageChanged(date: Date) {
        choosedDate = date
        weekPageViewController.select(newDate: date)
    }
    
    func changeDay(date: Date) {
        guard date.toString() != choosedDate.toString() else {
            return
        }
        
        let newDay = Router.dayViewController(with: date)
        newDay.delegate = dayPageViewController
        
        dayPageViewController.setViewControllers([newDay], direction: date.compare(choosedDate).rawValue == 1 ? .forward : .reverse, animated: true, completion: { (completed) in
            self.choosedDate = date
            newDay.delegate?.set(current: newDay)
        })
    }
    
}
