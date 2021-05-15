//
//  Book+CoreDataProperties.swift
//  LibraryManagement
//
//  Created by Arda Ersoy on 15.05.2021.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var image: String?
    @NSManaged public var isbn: String?
    @NSManaged public var price: Double
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var favoriteBooks: User?

}

extension Book : Identifiable {

}
