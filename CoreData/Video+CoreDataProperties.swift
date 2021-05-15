//
//  Video+CoreDataProperties.swift
//  LibraryManagement
//
//  Created by Arda Ersoy on 15.05.2021.
//
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var director: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var favoriteVideos: User?

}

extension Video : Identifiable {

}
