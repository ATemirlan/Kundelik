//
//  CalendarCollectionViewCell.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/26/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCollectionViewCell: JTAppleCell {

    @IBOutlet var selectedView: UIView!
    @IBOutlet var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectedView.layer.cornerRadius = selectedView.frame.size.width / 2.0
    }
    
    func set(selected: Bool) {
        selectedView.backgroundColor = selected ? Constants.Color.redColor : .white
        dayLabel.textColor = selected ? .white : .black
    }

}
