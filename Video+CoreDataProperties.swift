//
//  Video+CoreDataProperties.swift
//  LibraryManagement
//
//  Created by Arda ERSOY on 10.05.2021.
//
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: Keys.shared.VIDEO_DB)
    }

    @NSManaged public var name: String?
    @NSManaged public var director: String?
    @NSManaged public var url: String?

}

extension Video : Identifiable {

}
