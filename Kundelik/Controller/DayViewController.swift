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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: DayTableViewCell.nibName, bundle: nil),
                           forCellReuseIdentifier: DayTableViewCell.cellID)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegate?.set(current: self)
    }
    
}

extension DayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.cellID) as! DayTableViewCell
        
        if let event = events?[indexPath.row] {
            cell.titleLabel.text = event.title
        }
        
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
        
        guard let event = events?[indexPath.row] else {
            return
        }
        
        DispatchQueue.main.async {
            Alert.showActionSheet(vc: baseVC, title: nil, message: "Выберите действие", actions: [
                UIAlertAction(title: "Изменить", style: .default, handler: { (action) in
                    
                }),
                
                UIAlertAction(title: "Удалить", style: .destructive, handler: { (action) in
                    RealmController.shared.remove(event: event)
                    baseVC.newEventAdded()
                }),
                
                UIAlertAction(title: "Отменить", style: .cancel, handler: { (action) in
                    
                })
            ])
        }
    }
    
}
