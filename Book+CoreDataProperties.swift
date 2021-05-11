//
//  Book+CoreDataProperties.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 10.05.2021.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: Keys.shared.BOOK_DB)
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var summary: String?
    @NSManaged public var image: String?
    @NSManaged public var price: Double
    @NSManaged public var isbn: String?

}

extension Book : Identifiable {

}
