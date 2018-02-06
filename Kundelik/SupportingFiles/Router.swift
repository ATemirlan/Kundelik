//
//  Router.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class Router {
    
    static func pageViewController(with days: [DayViewController], frame: CGRect) -> PageViewController {
        let pageViewController = getViewController(with: PageViewController.className) as! PageViewController
        pageViewController.days = days
        pageViewController.set(days: days[0])
        pageViewController.view.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size)
        return pageViewController
    }
    
    static func dayViewController() -> DayViewController {
        return getViewController(with: DayViewController.className) as! DayViewController
    }

    private static func getViewController(with id: String) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id)
    }
    
}
