//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Mesut Aygün on 22.05.2021.
//

import SwiftUI

@main
struct BookWormApp: App {
    let PersistenceContainer = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext , PersistenceContainer.container.viewContext)
            
        }
    }
}
