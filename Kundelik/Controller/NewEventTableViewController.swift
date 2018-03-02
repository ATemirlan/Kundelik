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
    
    var delegate: NewEventProtocol?
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.isEnabled = false
        
        if event == nil {
            event = Event()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(event?.title)
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        guard let title = titleField.text, title.count > 0 else {
            return
        }
        
        RealmController.shared.add(eventTitle: title)
        delegate?.newEventAdded()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shouldRepeat(_ sender: UISwitch) {
        tableView.reloadData()
    }
    
    @IBAction func shouldNotify(_ sender: UISwitch) {
        
    }
    
}

extension NewEventTableViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, text.count > 0 {
            addButton.isEnabled = true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
}

extension NewEventTableViewController {
    
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
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
}
