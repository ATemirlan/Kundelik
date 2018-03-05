//
//  DayTableViewCell.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 1/23/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class DayTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setup(with event: Event) {
        titleLabel.text = event.title
        iconView.image = UIImage(named: event.categoryIcon)
        
        guard let start = event.startTime?.toTime(), let end = event.endTime?.toTime() else {
            return
        }
        
        dateLabel.text = "\(start) - \(end)"
    }
    
}
