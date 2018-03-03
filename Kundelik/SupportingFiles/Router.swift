//
//  Router.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import RealmSwift

class Router {
    
    static func weekPageViewController(with frame: CGRect) -> WeekPageViewController {
        let pageViewController = getViewController(with: WeekPageViewController.className) as! WeekPageViewController
        pageViewController.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        return pageViewController
    }
    
    static func weekViewController(with date: Date) -> WeekViewController {
        let week = getViewController(with: WeekViewController.className) as! WeekViewController
        week.currentDate = date
        return week
    }
    
    static func dayPageViewController(with frame: CGRect) -> DayPageViewController {
        let pageViewController = getViewController(with: DayPageViewController.className) as! DayPageViewController
        pageViewController.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        return pageViewController
    }
    
    static func dayViewController(with date: Date, events: Results<Event>?) -> DayViewController {
        let day = getViewController(with: DayViewController.className) as! DayViewController
        day.events = events
        day.date = date
        return day
    }

    static func showChangeViewController(event: Event?, at: UIViewController) {
        let navvc = getViewController(with: "NavigationController") as! UINavigationController
        let newEventVC = navvc.viewControllers[0] as! NewEventTableViewController
        newEventVC.event = event
        at.present(navvc, animated: true, completion: nil)
    }
    
    private static func getViewController(with id: String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id)
    }
    
}
