//
//  ProfileVC.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 20.04.2021.
//

import UIKit
import CoreData

class ProfileVC: UIViewController {
    
    // MARK: -
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: -
    var favoriteBooks = [Book](), favoriteVideos = [Video]()
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: -
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        fetchFavorites()
        tableView.reloadData()
    }
    
    // MARK: -
    private func fetchFavorites() {
     
    }
    
    // MARK: -
    @IBAction func logoutBtnTapped(_ sender: UIBarButtonItem) {
        ShowAlertWithAction(subTitle: "Do you really want to log out?") {
            let defaults = UserDefaults.standard
            defaults.setValue(false, forKey: "isLoggedIn")
            defaults.synchronize()
            
            self.performSegue(withIdentifier: "LogoutSegue", sender: self)
        }
        
        MediaPlayer.shared.playSound()
    }
}

// MARK: -
extension ProfileVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? favoriteBooks.count : favoriteVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AssetCell") as? AssetCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            let item = favoriteBooks[indexPath.row]
            cell.assetTitleLabel.text = item.title
            cell.assetDescLabel.text = item.author
            cell.assetSubtitleLabel.text = item.isbn
        case 1:
            let item = favoriteVideos[indexPath.row]
            cell.assetTitleLabel.text = item.name
            cell.assetDescLabel.text = item.director
            cell.assetSubtitleLabel.text = item.url
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Books" : "Videos"
    }
}
