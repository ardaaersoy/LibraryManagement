//
//  LoginVC.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 19.04.2021.
//

import UIKit

class LoginVC: UIViewController {

    // MARK: -
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBTN: UIButton!
    
    // MARK: -
    let defaults = UserDefaults.standard
    
    // MARK: - 
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: -
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        if let username = usernameTF.text, let password = passwordTF.text {
            if username.isEmpty || password.isEmpty {
                ShowAlert(style: .warning, subTitle: "Please, fill username and password field.")
            } else {
                if username != Keys.shared.AUTH_USERNAME || password != Keys.shared.AUTH_PASSWORD {
                    ShowAlert(style: .error, subTitle: "Wrong credentials provided.")
                } else {
                    defaults.setValue(true, forKey: "isLoggedIn")
                    defaults.synchronize()
                    
                    self.performSegue(withIdentifier: "LoginVcSegue", sender: self)
                }
            }
        }
    }
}
