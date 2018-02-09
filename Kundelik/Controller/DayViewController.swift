//
//  DayViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

protocol DayViewProtocol {
    func set(current day: DayViewController)
}

class DayViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var date: Date!
    var delegate: DayViewProtocol?
    
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.cellID) as! DayTableViewCell

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
}
