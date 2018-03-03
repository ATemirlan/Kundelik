//
//  WeekdayGray.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 3/3/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class WeekdayGray: UIButton {
    
    var date: Date!
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = frame.width / 2.0
        layer.masksToBounds = true
        
        setTitleColor(.black, for: .normal)
        backgroundColor = UIColor.lightGray
    }
    
    func set(selected: Bool) {
        isSelected = selected
        backgroundColor = selected ? Constants.Color.redColor : .lightGray
        setTitleColor(selected ? .white : .black, for: .normal)
    }
    
}
