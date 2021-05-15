//
//  AssetRepository.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 10.05.2021.
//

import CoreData

protocol IAssetRepository {
    func insertBook(book: BookModel, completion: @escaping (Bool) -> Void)
    func insertVideo(video: VideoModel, completion: @escaping (Bool) -> Void)
    func fetchAll<T: NSManagedObject>(entity: String, completion: @escaping ([T]?) -> Void)
}

class AssetRepository: BaseRepository, IAssetRepository {
    
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
    func fetchAll<T: NSManagedObject>(entity: String, completion: @escaping ([T]?) -> Void) {
        guard let context = context else { return completion(nil) }
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
    func delete(object: Book) {
        guard let context = context else { return }
        
        context.delete(object)
        save()
    }
}
