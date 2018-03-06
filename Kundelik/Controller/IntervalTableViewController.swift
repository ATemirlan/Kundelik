//
//  IntervalTableViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 3/3/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class IntervalTableViewController: UITableViewController {

    @IBOutlet var days: [WeekdayGray]!
    @IBOutlet weak var daysSwitch: UISwitch!
    
    var selectedDays = [Int]()
    var currentTag = -1
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        if let interval = event?.interval {
            if interval > 0 {
                daysSwitch.setOn(true, animated: false)
                
                for c in "\(interval)" {
                    selectedDays.append(Int("\(c)")!)
                    
                    let _ = days.map {
                        if $0.tag == Int("\(c)")! {
                            $0.set(selected: true)
                        }
                    }
                }
                
            } else {
                daysSwitch.setOn(false, animated: false)
            }
            
            currentTag = interval
            tableView.reloadData()
        }
    }
    
    @IBAction func selecteDay(_ sender: WeekdayGray) {
        if !selectedDays.contains(sender.tag) {
            selectedDays.append(sender.tag)
        } else {
            if let index = selectedDays.index(of: sender.tag) {
                selectedDays.remove(at: index)
            }
        }
        
        updateTag()
        sender.set(selected: !sender.isSelected)
    }
    
    func updateTag() {
        var str = ""
        let _ = selectedDays.map { str.append("\($0)") }
        
        if let newTag = Int(str) {
            currentTag = newTag
        }
    }
    
    @IBAction func atDaysOfWeek(_ sender: UISwitch) {
        currentTag = 0
        
        if sender.isOn {
            deselectAllDays()
        }
        
        tableView.reloadData()
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if let vc = backViewController() as? NewEventTableViewController {
            vc.event?.interval = currentTag
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return daysSwitch.isOn ? 2 : 1
        default:
            return 5
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = cell.tag == currentTag ? .checkmark : .none
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else {
            return
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 1 else {
            return
        }
        
        if let cell = tableView.cellForRow(at: indexPath) {
            daysSwitch.setOn(false, animated: true)
            cell.accessoryType = .checkmark
            currentTag = cell.tag
            deselectAllDays()
            tableView.reloadData()
        }
    }
    
    func deselectAllDays() {
        for day in days {
            day.set(selected: false)
        }
    }
    
}
