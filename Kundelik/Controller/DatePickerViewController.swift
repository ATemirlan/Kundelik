//
//  DatePickerViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 3/3/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol DatePickerProtocol {
    func dateChoosed(date: Date)
}
class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var event: Event?
    var delegate: DatePickerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        datePicker.minimumDate = Date()
        
        if let endDate = event?.endDate {
            datePicker.date = endDate
            datePicker.minimumDate = endDate
        }
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        delegate?.dateChoosed(date: datePicker.date)
        dismiss(animated: true, completion: nil)
    }
    
}
