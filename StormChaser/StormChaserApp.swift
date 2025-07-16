//
//  StormChaserApp.swift
//  StormChaser
//
//  Created by Tung on 16/7/2025.
//

import SwiftUI

@main
struct StormChaserApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
