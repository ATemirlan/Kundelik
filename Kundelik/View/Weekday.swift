//
//  weekday.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/7/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class Weekday: UIButton {

    var date: Date!
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.width / 2.0
        layer.masksToBounds = true
    }
    
    func set(date: Date) {
        self.date = date
        setTitle(date.day, for: .normal)
    }
    
    func set(selected: Bool) {
        backgroundColor = selected ? Constants.Color.redColor : .white
        setTitleColor(selected ? .white : .black, for: .normal)
    }

}
