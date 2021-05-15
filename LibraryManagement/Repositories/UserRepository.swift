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
    func insertFavorites(book: Book?, video: Video?, completion: @escaping (Bool) -> Void)
    func fetchFavorites(completion: @escaping ([Book]?, [Video]?) -> Void)
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
    func insertFavorites(book: Book?, video: Video?, completion: @escaping (Bool) -> Void) {
        guard let context = context else { return completion(false) }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.shared.USER_DB)
        request.predicate = NSPredicate(format: "username = %@", Keys.shared.AUTH_USERNAME)
        
        do {
            let results = try context.fetch(request)
            guard let users = results as? [User] else { return completion(false) }
            
            if let book = book, let video = video {
                users.first?.favoriteBooks = NSSet.init(array: [book])
                users.first?.favoriteVideos = NSSet.init(array: [video])
            }
            
            completion(true)
            save()
            
        } catch let error as NSError {
            print("Could not update data \(error), \(error.userInfo)")
            completion(false)
        }
    }
    
    // MARK: - Fetch user favorites if exist
    func fetchFavorites(completion: @escaping ([Book]?, [Video]?) -> Void) {
        guard let context = context else { return }
       
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.shared.USER_DB)
        request.predicate = NSPredicate(format: "username = %@", Keys.shared.AUTH_USERNAME)
        
        do {
            let results = try context.fetch(request)
            guard let users = results as? [User] else { return completion(nil, nil) }
            
            if let favoriteBooks = users.first?.favoriteBooks {
                for book in favoriteBooks {
                    print(book)
                }
            }
            
            if let favoriteVideos = users.first?.favoriteVideos {
                for video in favoriteVideos {
                    print(video)
                }
            }
            
            print("end")
            
        } catch let error as NSError {
            print("Could not fetch data \(error), \(error.userInfo)")
            completion(nil, nil)
        }
    }
}
