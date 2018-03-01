//
//  TestRealmViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/28/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit
import RealmSwift

class TestRealmViewController: UIViewController {
    
    @IBOutlet weak var field: UITextField!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func add(_ sender: Any) {
        RealmController.shared.add(eventTitle: field.text ?? "no title")
    }
    
    @IBAction func retrieve(_ sender: Any) {
        print(RealmController.shared.getEvents())
    }
    
}
