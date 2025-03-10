//
//  LocalStorageService.swift
//  Privacy Fortress
//
//  Created by Константин Клинов on 05/03/25.
//

import CoreData
import Foundation

struct LocalStorageService {
    
    static let shared = LocalStorageService()

    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "PrivacyFortress")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    public func deleteAllMediaItems() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MediaItemEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("All MediaItemEntity objects deleted successfully")
        } catch {
            let nsError = error as NSError
            print("Error deleting MediaItemEntity objects: \(nsError), \(nsError.userInfo)")
        }
    }
}
