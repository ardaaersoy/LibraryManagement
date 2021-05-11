//
//  User+CoreDataProperties.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 12.05.2021.
//
//

import Foundation
import CoreData

extension User {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var favoriteBooks: NSSet?
    @NSManaged public var favoriteVideos: NSSet?
}

// MARK: Generated accessors for favoriteBooks
extension User {

    @objc(addFavoriteBooksObject:)
    @NSManaged public func addToFavoriteBooks(_ value: Book)

    @objc(removeFavoriteBooksObject:)
    @NSManaged public func removeFromFavoriteBooks(_ value: Book)

    @objc(addFavoriteBooks:)
    @NSManaged public func addToFavoriteBooks(_ values: NSSet)

    @objc(removeFavoriteBooks:)
    @NSManaged public func removeFromFavoriteBooks(_ values: NSSet)

}

// MARK: Generated accessors for favoriteVideos
extension User {

    @objc(addFavoriteVideosObject:)
    @NSManaged public func addToFavoriteVideos(_ value: Video)

    @objc(removeFavoriteVideosObject:)
    @NSManaged public func removeFromFavoriteVideos(_ value: Video)

    @objc(addFavoriteVideos:)
    @NSManaged public func addToFavoriteVideos(_ values: NSSet)

    @objc(removeFavoriteVideos:)
    @NSManaged public func removeFromFavoriteVideos(_ values: NSSet)

}

extension User : Identifiable {

}
