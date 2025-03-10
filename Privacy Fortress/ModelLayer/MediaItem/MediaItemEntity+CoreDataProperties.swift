//
//  MediaItemEntity+CoreDataProperties.swift
//  
//
//  Created by Константин Клинов on 05/03/25.
//
//

import Foundation
import CoreData

extension MediaItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MediaItemEntity> {
        return NSFetchRequest<MediaItemEntity>(entityName: "MediaItemEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var imageData: Data?
    @NSManaged public var dateAdded: Date?

}
