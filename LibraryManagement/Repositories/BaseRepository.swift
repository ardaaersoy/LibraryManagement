//
//  BaseRepository.swift
//  LibraryManagement
//
//  Created by Arda Ersoy on 15.05.2021.
//

import UIKit
import CoreData

class BaseRepository {
    
    // MARK: - Managed object context
    var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let managedContext = appDelegate.persistentContainer.viewContext
        return managedContext
    }
    
    // MARK: - Save current context
    func save() {
        guard let context = context else { return }
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("Could not save data \(error), \(error.userInfo)")
        }
    }
}
