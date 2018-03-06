//
//  RealmController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 3/1/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import RealmSwift

class RealmController {
    
    static let shared = RealmController()
    private var realm: Realm?
    
    private init() {
        do {
            self.realm = try Realm()
        } catch {
            guard let vc = UIApplication.shared.keyWindow?.viewController() else {
                return
            }
            
            Alert.showError(textError: "Ошибка базы данных", above: vc)
        }
    }
    
    func add(event: Event) {
        if event.endDate == nil {
            event.endDate = Date().yearsAfter.yearsAfter
        }
        
        do {
            try realm?.write {
                realm?.add(event)
            }
        } catch (let error) {
            print(error)
        }
    }
    
    func getEvents(completion: @escaping (_ events: Results<Event>?) -> Void) {
        guard let events = realm?.objects(Event.self) else {
            completion(nil)
            return
        }
        
        completion(events.sorted(byKeyPath: "startTime", ascending: true))
    }
    
    func remove(event: Event) {
        do {
            try realm?.write {
                realm?.delete(event)
            }
        } catch (let error) {
            print(error)
        }
    }
    
}
