//
//  Persistence.swift
//  BookWorm
//
//  Created by Mesut Aygün on 22.05.2021.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container : NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "BookWorm")
        container.loadPersistentStores { storeDescriptor, error in
            if let error = error as NSError? {
                fatalError("error : \(error)")
            }
        }
    }
}
