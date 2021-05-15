//
//  UserRepository.swift
//  LibraryManagement
//
//  Created by Arda Ersoy on 15.05.2021.
//

import CoreData

protocol IUserRepository {
    func insert(username: String, password: String, completion: @escaping (Bool) -> Void)
    func fetch(username: String, password: String, completion: @escaping (User?) -> Void)
    func insertFavorites(asset: NSManagedObject, completion: @escaping (Bool) -> Void)
    func fetchFavorites(completion: @escaping ([Book], [Video]) -> Void)
}

class UserRepository: BaseRepository, IUserRepository {
    
    // MARK: - Insert a user to database
    func insert(username: String, password: String, completion: @escaping (Bool) -> Void) {
        guard let context = context else { return completion(false) }
        guard let userObject = NSEntityDescription.insertNewObject(forEntityName: Keys.shared.USER_DB, into: context) as? User else { return completion(false) }
        
        userObject.username = username
        userObject.password = password
        
        save()
        completion(true)
    }
    
    // MARK: - Fetch existing user from database
    func fetch(username: String, password: String, completion: @escaping (User?) -> Void) {
        guard let context = context else { return completion(nil) }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.shared.USER_DB)
        request.predicate = NSPredicate(format: "username = %@", username)
        request.predicate = NSPredicate(format: "password = %@", password)
        
        do {
            let results = try context.fetch(request)
            guard let users = results as? [User] else { return completion(nil) }
            completion(users.first)
            
        } catch let error as NSError {
            print("Could not fetch data \(error), \(error.userInfo)")
            completion(nil)
        }
    }
    
    // MARK: - Insert new favorite data to specified user
    func insertFavorites(asset: NSManagedObject, completion: @escaping (Bool) -> Void) {
        guard let context = context else { return completion(false) }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.shared.USER_DB)
        request.predicate = NSPredicate(format: "username = %@", Keys.shared.AUTH_USERNAME)
        
        do {
            let results = try context.fetch(request)
            guard let users = results as? [User] else { return completion(false) }
            
            if asset is Book {
                if let favoriteBooks = users.first?.favoriteBooks {
                    if !favoriteBooks.contains(where: { item in (item as? Book)?.isbn == (asset as? Book)?.isbn }) {
                        users.first?.addToFavoriteBooks((asset as? Book)!)
                        
                        save()
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
            
            if asset is Video {
                if let favoriteVideos = users.first?.favoriteVideos {
                    if !favoriteVideos.contains(where: { item in (item as? Video)?.url == (asset as? Video)?.url }) {
                        users.first?.addToFavoriteVideos((asset as? Video)!)
                        
                        save()
                        completion(true)
                    } else {
                        completion(false)
                    }
                }
            }
            
        } catch let error as NSError {
            print("Could not update data \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    // MARK: - Fetch user favorites if exist
    func fetchFavorites(completion: @escaping ([Book], [Video]) -> Void) {
        guard let context = context else { return completion([], []) }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.shared.USER_DB)
        request.predicate = NSPredicate(format: "username = %@", Keys.shared.AUTH_USERNAME)
        
        do {
            let results = try context.fetch(request)
            guard let users = results as? [User] else { return completion([], []) }
            
            if let favoriteBooks = users.first?.favoriteBooks, let favoriteVideos = users.first?.favoriteVideos {
                var books = [Book]()
                for book in favoriteBooks {
                    guard let book = book as? Book else { return completion([], []) }
                    books.append(book)
                }
                
                var videos = [Video]()
                for video in favoriteVideos {
                    guard let video = video as? Video else { return completion([], []) }
                    videos.append(video)
                }
                
                completion(books, videos)
            }
            
        } catch let error as NSError {
            print("Could not fetch data \(error), \(error.userInfo)")
            completion([], [])
        }
    }
}
