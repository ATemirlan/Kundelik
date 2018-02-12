//
//  BaseViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, PageControllerDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var weekdays: [Weekday]!
    
    var pageViewController: PageViewController!
    var chooseDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Date().toString()
        
        setupCalendar()
        setupDaysViewController()
        setupNavigationController()
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupCalendar() {
        chooseDate = Date()
        
        guard let startOfWeek = Date().startOfWeek?.yesterday else {
            return
        }
        
        for i in (0...6) {
            let date = Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)
            weekdays[i].set(date: date ?? Date())
            
            if date!.toString() == Date().toString() {
                weekdays[i].set(selected: true)
            }
        }
    }
    
    func setupDaysViewController() {
        pageViewController = Router.pageViewController(with: contentView.frame)
        pageViewController.pageDelegate = self
        addChildViewController(pageViewController)
        contentView.addSubview(pageViewController.view)
    }

    func pageChanged(date: Date) {
        unselectAll()
        
        for day in weekdays {
            if day.date.toString() == date.toString() {
                day.set(selected: true)
            }
        }
    }
    
    @IBAction func selected(_ sender: Weekday) {
        if sender.date.toString() != chooseDate.toString() {
            unselectAll()
            sender.set(selected: true)
            
            let newDay = Router.dayViewController(with: sender.date)
            newDay.delegate = pageViewController
            
            pageViewController.setViewControllers([newDay], direction: sender.date.compare(chooseDate).rawValue == 1 ? .forward : .reverse, animated: true, completion: { (completed) in
                self.chooseDate = sender.date
                newDay.delegate?.set(current: newDay)
            })
        }
    }
    
    func unselectAll() {
        for day in weekdays {
            day.set(selected: false)
        }
    }
    
}
