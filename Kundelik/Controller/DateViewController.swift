//
//  DateViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 3/3/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let startTime = event?.startTime, let endTime = event?.endTime {
            fromDatePicker.date = startTime
            toDatePicker.date = endTime
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if let vc = backViewController() as? NewEventTableViewController {
            vc.event?.startTime = fromDatePicker.date
            vc.event?.endTime = toDatePicker.date
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func fromDateChanged(_ sender: UIDatePicker) {
        if fromDatePicker.date.compare(toDatePicker.date).rawValue == -1 {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    @IBAction func toDateChanged(_ sender: UIDatePicker) {
        if fromDatePicker.date.compare(toDatePicker.date).rawValue == -1 {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}
