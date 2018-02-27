//
//  BaseViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, WeekPageControllerDelegate, DayPageControllerDelegate, CalendarProtocol {

    @IBOutlet weak var dayContainer: UIView!
    @IBOutlet weak var weekContainer: UIView!
    
    var dayPageViewController: DayPageViewController!
    var weekPageViewController: WeekPageViewController!
    
    var choosedDate: Date! = Date()
    
    lazy var blurView: UIView = {
        self.blurView = UIView(frame: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: UIApplication.shared.keyWindow!.frame.size))
        self.blurView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return self.blurView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupWeekViewController()
        setupDaysViewController()
        setEmptyBackButton()
    }
    
    func setupNavigationController() {
        title = choosedDate.toString()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupDaysViewController(with date: Date = Date()) {
        dayPageViewController = Router.dayPageViewController(with: dayContainer.frame)
        dayPageViewController.dayDelegate = self
        dayPageViewController.date = date
        addChildViewController(dayPageViewController)
        dayContainer.addSubview(dayPageViewController.view)
    }
    
    func setupWeekViewController(with date: Date = Date()) {
        weekPageViewController = Router.weekPageViewController(with: weekContainer.frame)
        weekPageViewController.weekDelegate = self
        weekPageViewController.date = date
        addChildViewController(weekPageViewController)
        weekContainer.addSubview(weekPageViewController.view)
    }
    
    @IBAction func showCalendar(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: CalendarViewController.segueID, sender: choosedDate)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CalendarViewController.segueID {
            view.addSubview(blurView)
            let calendarVC = segue.destination as! CalendarViewController
            calendarVC.delegate = self
            calendarVC.currentDate = sender as! Date
        }
    }
    
    // MARK: - Calendar Delegate
    
    func newDateChoosed(newDate: Date?) {
        blurView.removeFromSuperview()
        
        guard let date = newDate else {
            return
        }
        
        title = date.toString()
        choosedDate = date
        
        weekPageViewController.removeFromParentViewController()
        setupWeekViewController(with: date)
        
        dayPageViewController.removeFromParentViewController()
        setupDaysViewController(with: date)
    }
    
    // MARK: - Day Delegate
    
    func pageChanged(date: Date) {
        choosedDate = date
        weekPageViewController.select(newDate: date)
    }
    
    // MARK: - Week Delegates
    
    func newDateSelected(date: Date) {
        changeDay(date: date)
    }
    
    func changeDay(date: Date) {
        guard date.toString() != choosedDate.toString() else {
            return
        }
        
        let newDay = Router.dayViewController(with: date)
        newDay.delegate = dayPageViewController
        
        dayPageViewController.setViewControllers([newDay], direction: date.compare(choosedDate).rawValue == 1 ? .forward : .reverse, animated: true, completion: { (completed) in
            newDay.delegate?.set(current: newDay)
        })
    }
    
}
