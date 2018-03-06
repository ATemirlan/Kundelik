//
//  DayViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import RealmSwift

protocol DayViewProtocol {
    func set(current day: DayViewController)
}

class DayViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var date: Date!
    var delegate: DayViewProtocol?
    
    var events: Results<Event>?
    private var todayEvents = List<Event>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: DayTableViewCell.nibName, bundle: nil),
                           forCellReuseIdentifier: DayTableViewCell.cellID)
        
        filterEvents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.set(current: self)
//        filterEvents()
    }
    
    func filterEvents() {
        guard let events = events, events.count > 0 else {
            return
        }
        
        todayEvents = List<Event>()

        for e in events {
//            e.dump()
            if (compare(e.startDate!, date) == .orderedAscending && compare(e.endDate!, date) == .orderedDescending) ||
                compare(e.startDate!, date) == .orderedSame {
                switch e.interval {
                case Interval.never.rawValue: // done
                    if compare(e.startDate!, date) == .orderedSame {
                        todayEvents.append(e)
                    }
                    break
                case Interval.everyDay.rawValue: // done
                    todayEvents.append(e)
                    break
                case Interval.everyWeek.rawValue: // done
                    if e.startDate?.dayOfWeek() == date.dayOfWeek() {
                        todayEvents.append(e)
                    }
                    break
                case Interval.everyMonth.rawValue: // done
                    if e.startDate!.day == date.day {
                        todayEvents.append(e)
                    }
                    break
                case Interval.everyYear.rawValue: // done
                    if e.startDate!.day == date.day, e.startDate!.month == date.month {
                        todayEvents.append(e)
                    }
                    break
                default: // here parse days of week
                    if String(e.interval).contains(String(date.dayNumberOfWeek())) {
                        todayEvents.append(e)
                    }
                    
                    break
                }
            }
        }
        
        tableView.reloadData()
    }
    
    func compare(_ date1: Date, _ date2: Date) -> ComparisonResult {
        return NSCalendar.current.compare(date1, to: date2, toGranularity: .day)
    }
    
}

extension DayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.cellID) as! DayTableViewCell
        
        let event = todayEvents[indexPath.row]
        cell.setup(with: event)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let baseVC = UIApplication.shared.keyWindow?.rootViewController?.childViewControllers.first as? BaseViewController else {
            return
        }
        
        let event = todayEvents[indexPath.row]
        
        DispatchQueue.main.async {
            Alert.showActionSheet(vc: baseVC, title: nil, message: "Выберите действие", actions: [
                UIAlertAction(title: "Удалить", style: .destructive, handler: { (action) in
                    RealmController.shared.remove(event: event)
                    baseVC.newEventAdded()
                }),
                
                UIAlertAction(title: "Отменить", style: .cancel, handler: { (action) in })
            ])
        }
    }
    
}
