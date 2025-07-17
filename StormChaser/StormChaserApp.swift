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
    @StateObject private var appThemeManager = AppThemeManager()

     init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.backgroundColor = UIColor.white // or your preferred color
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some Scene {
        WindowGroup {
//            ContentView().environment(\.managedObjectContext, persistenceController.container.viewContext)
            ContentView().environmentObject(appThemeManager)
        }
    }
}
