//
//  Event.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/28/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import RealmSwift

enum Interval: Int {
    case never = -1
    case everyDay = -2
    case everyWeek = -3
    case every2Weeks = -4
    case everyMonth = -5
    case everyYear = -6
}

final class Event: Object {
    
    @objc dynamic var title = ""
    @objc dynamic var category = ""
    @objc dynamic var categoryIcon = ""
    
    @objc dynamic var startTime: Date? = nil
    @objc dynamic var endTime: Date? = nil

    @objc dynamic var startDate: Date? = nil
    @objc dynamic var endDate: Date? = nil
    
    @objc dynamic var interval: Int = Interval.never.rawValue
    @objc dynamic var shouldNotify = false
    
    func canSave() -> Bool {
        if title.count > 0, category.count > 0, categoryIcon.count > 0, startTime != nil, endTime != nil {
            return true
        }
        
        return false
    }
    
    func dump() {
        print("----------------")
        print("Title: \(title)")
        print("Category: \(category)")
        print("Start time: \(startTime))")
        print("End time: \(endTime))")
        print("Start date: \(startDate))")
        print("End date: \(endDate))")
        print("Interval: \(interval))")
        print("Should notify: \(shouldNotify))")
        print("----------------")
    }
    
}
