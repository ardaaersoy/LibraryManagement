//
//  HomeVC.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 19.04.2021.
//

import UIKit
import CoreData

class HomeVC: UIViewController {
    
    // MARK: - Required outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var assetSegmentedControl: UISegmentedControl!
    
    // MARK: - Define variables
    var books = [Book](), videos = [Video]()
    var selectedAsset: NSManagedObject?
    var favoriteBooks = [Book](), favoriteVideos = [Video]()
    var isSelectedAssetBook = true
    var _assetRepository: IAssetRepository = AssetRepository()
    var _userRepository: IUserRepository = UserRepository()
    
    // MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchBooks()
        fetchVideos()
        
        tableView.reloadData()
    }
    
    // MARK: - Unwind segue to pop vc
    @IBAction func unwindToHome(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
    // MARK: - Handle segmented control change
    @IBAction func didAssetChanged(_ sender: UISegmentedControl) {
        isSelectedAssetBook = !isSelectedAssetBook
        tableView.reloadData()
    }
    
    // MARK: - Load data if there is not existing assets in core data
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
        
        if let path = Bundle.main.path(forResource: "VideoStore", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let videos = try JSONDecoder().decode([VideoModel].self, from: data)
                
                insertVideos(videos)
                
            } catch let err {
                print("err", err)
            }
        }
    }
    
    // MARK: - Insert assets that are parsed from json files
    private func insertBooks(_ books: [BookModel]) {
        for book in books {
            _assetRepository.insertBook(book: book, completion: { isInserted in
                if isInserted {
                    print("\(book.title) is inserted.")
                }
            })
        }
        
        fetchBooks()
    }
    
    private func insertVideos(_ videos: [VideoModel]) {
        for video in videos {
            _assetRepository.insertVideo(video: video) { isInserted in
                if isInserted {
                    print("\(video.name) is inserted.")
                }
            }
        }
        
        fetchVideos()
    }
    
    // MARK: - Fetch all assets to display
    private func fetchBooks() {
        _assetRepository.fetchAll(entity: Keys.shared.BOOK_DB) { (allBooks: [Book]?) in
            guard let books = allBooks else { print("ee"); return }
            
            if !books.isEmpty {
                self.books = books
            } else {
                self.loadData()
            }
        }
    }
    
    private func fetchVideos() {
        _assetRepository.fetchAll(entity: Keys.shared.VIDEO_DB) { (allVideos: [Video]?) in
            guard let videos = allVideos else { return }
            
            if !videos.isEmpty {
                self.videos = videos
            } else {
                self.loadData()
            }
        }
    }
    
    // MARK: - Handle favorite button click, to add a new favorite asset to user
    private func handleMarkAsFavourite(favorite: NSManagedObject) {
//        if !favourites.contains(where: { (item) -> Bool in item.isbn == favourite.isbn }) {
//            favourites.append(favourite)
//        }

        _userRepository.insertFavorites(book: isSelectedAssetBook ? (favorite as? Book) : nil, video: !isSelectedAssetBook ? (favorite as? Video) : nil) { isInserted in
            if isInserted {
                print("User added a new favorite.")
            }
        }
        
        ShowAlert(style: .success, subTitle: "You have marked the asset as favourite.")
        MediaPlayer.shared.playSound()
    }
    
    // MARK: - Prepare segue, pass asset details for detailVC to display
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVcSegue" {
            guard let vc = segue.destination as? DetailVC else { return }
            vc.asset = selectedAsset
        }
    }
}

// MARK: - Tableview extension for displaying all books and videos
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
        let action = UIContextualAction(style: .normal, title: Keys.shared.FAVOURITE) { [weak self] (action, view, completionHandler) in self?.handleMarkAsFavourite(favorite: self!.isSelectedAssetBook ? (self?.books[indexPath.row])! : (self?.videos[indexPath.row])!)
            completionHandler(true)
        }
        action.image = UIImage.init(systemName: "star.fill")
        action.backgroundColor = UIColor(named: "DarkBlue")
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedAsset = isSelectedAssetBook ? books[indexPath.row] : videos[indexPath.row]
        self.performSegue(withIdentifier: "DetailVcSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isSelectedAssetBook ? 180.0 : 130.0
    }
}
