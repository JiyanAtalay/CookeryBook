//
//  CookeryBookApp.swift
//  CookeryBook
//
//  Created by Mehmet Jiyan Atalay on 13.07.2024.
//

import SwiftUI

@main
struct CookeryBookApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CooksListView().preferredColorScheme(.light)
            }.modelContainer(for: [CookModel.self])
        }
    }
}
