//
//  Database.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 10.05.2021.
//

import UIKit
import CoreData

class Database {
    
    static let shared = Database()
    
    // MARK: -
    private var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    // MARK: -
    func insertBook(book: BookModel, completion: @escaping (Bool) -> Void) {
        guard let context = context else { return completion(false) }
        guard let bookObject = NSEntityDescription.insertNewObject(forEntityName: Keys.shared.BOOK_DB, into: context) as? Book else { return completion(false) }
        
        bookObject.isbn = book.ISBN
        bookObject.title = book.title
        bookObject.author = book.author
        bookObject.summary = book.summary
        bookObject.image = book.image
        bookObject.price = book.price
        
        save()
        completion(true)
    }
    
    // MARK: -
    func insertVideo(video: VideoModel, completion: @escaping (Bool) -> Void) {
        guard let context = context else { return completion(false) }
        guard let videoObject = NSEntityDescription.insertNewObject(forEntityName: Keys.shared.VIDEO_DB, into: context) as? Video else { return completion(false) }
        
        videoObject.name = video.name
        videoObject.director = video.director
        videoObject.url = video.url
        
        save()
        completion(true)
    }
    
    // MARK: -
    func insertFavorites(book: Book?, video: Video?, completion: @escaping (Bool) -> Void) {
        guard let context = context else { return completion(false) }
        guard let userObject = NSEntityDescription.insertNewObject(forEntityName: Keys.shared.USER_DB, into: context) as? User else { return completion(false) }
        
        if let book = book {
            userObject.favoriteBooks = NSSet.init(array: [book])
        }
        
        if let video = video {
            userObject.favoriteVideos = NSSet.init(array: [video])
        }
        
        save()
        completion(true)
    }
    
    // MARK: -
    func fetchData<T: NSManagedObject>(entity: String, completion: @escaping ([T]?) -> Void) {
        guard let context = context else { return }
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        do {
            let results = try context.fetch(fetchRequest)
            guard let allBooks = results as? [T] else { return }
            completion(allBooks)

        } catch let error as NSError {
            print("Could not fetch data \(error), \(error.userInfo)")
            completion(nil)
        }
    }
    
    // MARK: -
    func fetchUserFavorites(subEntity: String, completion: @escaping (Bool?) -> Void) {
        guard let context = context else { return }
        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Keys.shared.USER_DB)
//
//        do {
//            let results = try context.fetch(fetchRequest)
//            guard let user = resultsUser else { return }
//
//            guard let favoriteBooks = user.favoriteBooks else { return }
//            for item in favoriteBooks {
//
//            }
//
//            guard let favoriteVideos = user.favoriteVideos else { return }
//            for item in favoriteVideos {
//                print((item as? Video)?.name)
//            }
//        } catch let error as NSError {
//            print("Could not fetch data \(error), \(error.userInfo)")
//            completion(nil)
//        }
    }
    
    // MARK: -
    func save() {
        guard let context = context else { return }
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save data \(error), \(error.userInfo)")
        }
    }
    
    // MARK: -
    func delete(object: Book) {
        guard let context = context else { return }
        
        context.delete(object)
        save()
    }
}
