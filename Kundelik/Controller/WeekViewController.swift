//
//  WeekViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/15/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol WeekViewProtocol {
    func set(current week: WeekViewController)
    func select(date: Date)
}

class WeekViewController: UIViewController {

    @IBOutlet var weekdays: [Weekday]!
    
    var currentDate: Date!
    var delegate: WeekViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.set(current: self)
        updateCalendar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unselectAll()
    }
    
    func setupCalendar() {
        guard let startOfWeek = currentDate.startOfWeek?.yesterday else {
            return
        }
        
        for i in (0...6) {
            let date = Calendar.current.date(byAdding: .day, value: i, to: startOfWeek)
            weekdays[i].set(date: date ?? Date())
        }
    }
    
    func updateCalendar() {
        for day in weekdays {
            if day.date.toString() == currentDate.toString() {
                day.set(selected: true)
            }
        }
    }
    
    @IBAction func selectDay(_ sender: Weekday) {
        if sender.date.toString() != currentDate.toString() {
            unselectAll()
            sender.set(selected: true)
            delegate?.select(date: sender.date)
        }
    }
    
    func unselectAll() {
        for day in weekdays {
            day.set(selected: false)
        }
    }
    
}
