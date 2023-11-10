//
//  AlmaMapApp.swift
//  AlmaMap
//
//  Created by Ines Fraccalvieri on 04/05/23.
//

import SwiftUI

@main
struct AlmaMapApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomePageView(viewModel: DataLoader())
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
