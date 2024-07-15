//
//  ContentView.swift
//  CookeryBook
//
//  Created by Mehmet Jiyan Atalay on 13.07.2024.
//

import SwiftUI
import SwiftData

struct ingredientsView: View {
    @State private var ingredients: [Ingredient] = [Ingredient(name: "", quantity: 0)]
    @State private var name = ""
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State var cook : CookModel?
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Ingredients")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Enter cook name", text: $name)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                ForEach(0..<ingredients.count, id: \.self) { index in
                    HStack {
                        TextField("Enter ingredient", text: $ingredients[index].name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Picker("Quantity", selection: $ingredients[index].quantity) {
                            ForEach(Array(stride(from: 0, through: 5000, by: 10)), id: \.self) { i in
                                Text("\(i) g").tag(i)
                            }
                        }
                        .frame(width: 100)
                        .clipped()
                        
                        Button(action: {
                            ingredients.remove(at: index)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal)
                }
                HStack {
                    Button(action: {
                        ingredients.append(Ingredient(name: "", quantity: 0))
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .padding()
                    
                    Button(action: {
                        if let cook = cook {
                            cook.name = name
                            cook.list = ingredients
                            
                            do {
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                            
                        } else {
                            let data = CookModel(name: name, list: ingredients)
                            
                            context.insert(data)
                            
                            do {
                                try context.save()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                        dismiss()
                        
                    }, label: {
                        Text("Save")
                            .padding()
                            .foregroundColor(.blue)
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 2))
                    })
                }
                Spacer()
            }
        }
        .onAppear {
            if let cook = cook {
                name = cook.name
                ingredients = cook.list
            }
        }
    }
}

#Preview {
    NavigationStack {
        ingredientsView()
    }.modelContainer(for: [CookModel.self])
}
