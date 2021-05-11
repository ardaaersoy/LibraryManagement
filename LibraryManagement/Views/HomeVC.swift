//
//  HomeVC.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 19.04.2021.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    // MARK: -
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var assetSegmentedControl: UISegmentedControl!
    
    // MARK: -
    var books = [Book](), videos = [Video]()
    var selectedAsset: NSManagedObject?
    var favourites = [Book]()
    var isSelectedAssetBook = true
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    @IBAction func didAssetChanged(_ sender: UISegmentedControl) {
        isSelectedAssetBook = !isSelectedAssetBook
        tableView.reloadData()
    }
    
    // MARK: -
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    // MARK: -
    private func loadData() {
        if let path = Bundle.main.path(forResource: "BookStore", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let books = try JSONDecoder().decode([BookModel].self, from: data)
                  
                insertBooks(books)
                
            } catch let err {
                print("err", err)
            }
        }
    }
    
    // MARK: -
    private func insertBooks(_ books: [BookModel]) {
        for book in books {
            Database.shared.insertBook(book: book) { isInserted in
                if isInserted {
                    print("\(book.ISBN) is inserted.")
                }
            }
        }
        
        fetchData()
    }
    
    // MARK: -
    private func fetchData() {
        Database.shared.fetchData(entity: Keys.shared.BOOK_DB) { (allBooks: [Book]?) in
            guard let books = allBooks else { print("none"); return }
            
            if !books.isEmpty {
                self.books = books
                self.tableView.reloadData()
            } else {
                self.loadData()
            }
        }
    }
    
    // MARK: -
    private func handleMarkAsFavourite(favourite: NSManagedObject) {
//        if !favourites.contains(where: { (item) -> Bool in item.isbn == favourite.isbn }) {
//            favourites.append(favourite)
//
//            ShowAlert(style: .success, subTitle: "You have marked the book as favourite.")
//        }
    }
    
    // MARK: -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVcSegue" {
            guard let vc = segue.destination as? DetailVC else { return }
            vc.asset = selectedAsset
        }
    }
}

// MARK: -
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSelectedAssetBook ? books.count : videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isSelectedAssetBook {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell") as? BookCell else { return UITableViewCell() }
            
            let item = books[indexPath.row]
            cell.bookImageView.setKfImage(url: item.image)
            cell.bookTitleLabel.text = item.title
            cell.bookAuthorLabel.text = item.author
            cell.bookSummaryLabel.text = item.summary
            cell.bookPriceLabel.text = "$" + item.price.description
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as? VideoCell else { return UITableViewCell() }
            
            let item = videos[indexPath.row]
            cell.videoNameLabel.text = item.name
            cell.videoDirectorLabel.text = item.director
            cell.videoUrlLabel.text = item.url
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Favorite") { [weak self] (action, view, completionHandler) in self?.handleMarkAsFavourite(favourite: (self?.books[indexPath.row])!)
            completionHandler(true)
        }
        action.image = UIImage.init(systemName: "star.fill")
        action.backgroundColor = UIColor(named: "DarkBlue")
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAsset = books[indexPath.row]
        print(selectedAsset ?? "")
        self.performSegue(withIdentifier: "DetailVcSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isSelectedAssetBook ? 180.0 : 140.0
    }
}
