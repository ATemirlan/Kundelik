//
//  KundelikViewController.swift
//  Kundelik
//
//  Created by Темирлан Алпысбаев on 2/27/18.
//  Copyright © 2018 Alpysbayev. All rights reserved.
//

import UIKit

class KundelikViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private let correctLogin = "Login"
    private let correctPassword = "Password"
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func goBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func login(_ sender: UIButton) {
        guard let login = loginField.text, let password = passwordField.text,
            login.count > 0, password.count > 0 else {
            Alert.showError(textError: "Не все поля заполнены", above: self)
            return
        }
        
        showSpinner(deadline: 3.0) {
            if login == self.correctLogin, password == self.correctPassword {
                self.dismiss(animated: true, completion: nil)
            } else {
                Alert.showError(textError: "Неверный логин или пароль", above: self)
            }
        }
    }
    
}
