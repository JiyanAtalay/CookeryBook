//
//  CooksListView.swift
//  CookeryBook
//
//  Created by Mehmet Jiyan Atalay on 14.07.2024.
//

import SwiftUI
import SwiftData

struct CooksListView: View {
    
    @Query private var cooks : [CookModel]
    
    @State private var isAddToDoPresented : Bool = false
    
    var body: some View {
        NavigationStack {
            List(cooks) { cook in
                NavigationLink(cook.name) {
                    ingredientsView(cook: cook)
                }
                
            }.navigationTitle("Cookery Book")
                .toolbar(content: {
                    ToolbarItem {
                        Button(action: {
                            isAddToDoPresented = true
                        }, label: {
                            Image(systemName: "plus")
                        })
                    }
                }).sheet(isPresented: $isAddToDoPresented, onDismiss: {
                    isAddToDoPresented = false
                }, content: {
                    ingredientsView()
                })
        }
    }
}

#Preview {
    NavigationStack {
        CooksListView()
    }.modelContainer(for: [CookModel.self])
}
