//
//  CookModel.swift
//  CookeryBook
//
//  Created by Mehmet Jiyan Atalay on 14.07.2024.
//

import Foundation
import SwiftData

@Model
class CookModel{
    let id : UUID = UUID()
    var name : String
    var list : [Ingredient]
    
    init(name: String, list: [Ingredient]) {
        self.name = name
        self.list = list
    }
}

struct Ingredient : Identifiable, Codable { // hatayi boyle coz
    var id = UUID()
    var name: String
    var quantity: Int
}
