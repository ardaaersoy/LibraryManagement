//
//  ProfileVC.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 20.04.2021.
//

import UIKit

class ProfileVC: UIViewController {
    
    // MARK: -
    var favorites = [Book]()
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDummyData()
    }
    
    // MARK: -
    private func loadDummyData() {
        
    }
    
    // MARK: -
    @IBAction func logoutBtnTapped(_ sender: UIBarButtonItem) {
        ShowAlertWithAction(subTitle: "Do you really want to log out?") {
            let defaults = UserDefaults.standard
            defaults.setValue(false, forKey: "isLoggedIn")
            defaults.synchronize()
            
            self.performSegue(withIdentifier: "LogoutSegue", sender: self)
        }
    }
}
