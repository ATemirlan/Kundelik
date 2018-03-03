//
//  NewEventTableViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/28/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol NewEventProtocol {
    func newEventAdded()
}

class NewEventTableViewController: UITableViewController {

    @IBOutlet weak var addButton: UIBarButtonItem!
    
    @IBOutlet weak var repeatSwitch: UISwitch!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var titleField: UITextField!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    var delegate: NewEventProtocol?
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEmptyBackButton()
        addButton.isEnabled = false
        
        if event == nil {
            event = Event()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        event?.dump()
        updateUI()
    }

    func updateUI() {
        categoryLabel.isHidden = true
        timeLabel.isHidden = true
        endDateLabel.isHidden = true
        
        if let title = event?.title {
            titleField.text = title
        }
        
        if let category = event?.category {
            categoryLabel.text = category
            categoryLabel.isHidden = false
        }
        
        if let startTime = event?.startTime?.toTime(), let endTime = event?.endTime?.toTime() {
            timeLabel.text = "\(startTime) - \(endTime)"
            timeLabel.isHidden = false
        }
        
        if let endDate = event?.endDate?.toString() {
            endDateLabel.text = endDate
            endDateLabel.isHidden = false
        }
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        guard let title = titleField.text, title.count > 0 else {
            return
        }
        
        if let event = event {
            RealmController.shared.add(event: event)
            delegate?.newEventAdded()
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func shouldRepeat(_ sender: UISwitch) {
        tableView.reloadData()
    }
    
    @IBAction func shouldNotify(_ sender: UISwitch) {
        event?.shouldNotify = sender.isOn
    }
    
}

extension NewEventTableViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.count > 0 {
            event?.title = text
            addButton.isEnabled = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
}

extension NewEventTableViewController: DatePickerProtocol {
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return repeatSwitch.isOn ? 3 : 1
        case 2:
            return notificationSwitch.isOn ? 1 : 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if indexPath == IndexPath(row: 2, section: 1) {
                self.performSegue(withIdentifier: DatePickerViewController.segueID, sender: self.event)
            } else if indexPath == IndexPath(row: 1, section: 1) {
                self.performSegue(withIdentifier: IntervalTableViewController.segueID, sender: self.event)
            } else if indexPath == IndexPath(row: 2, section: 0) {
                self.performSegue(withIdentifier: DateViewController.segueID, sender: self.event)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DatePickerViewController.segueID {
            let vc = segue.destination as! DatePickerViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.delegate = self
            vc.event = (sender as! Event)
        } else if segue.identifier == IntervalTableViewController.segueID {
            let vc = segue.destination as! IntervalTableViewController
            vc.modalPresentationStyle = .overFullScreen
            vc.event = (sender as! Event)
        } else if segue.identifier == DateViewController.segueID {
            let vc = segue.destination as! DateViewController
            vc.event = (sender as! Event)
        }
    }
    
    func dateChoosed(date: Date) {
        event?.endDate = date
        updateUI()
    }
    
}
