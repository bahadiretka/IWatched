//
//  IWatchedApp.swift
//  IWatched
//
//  Created by Bahadır Kılınç on 9.08.2022.
//

import SwiftUI

@main
struct IWatchedApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
