//
//  weekday.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/7/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class Weekday: UIButton {

    func set(selected: Bool) {
        backgroundColor = selected ? .red : .black
    }

}
