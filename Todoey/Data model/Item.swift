//
//  Item.swift
//  Todoey
//
//  Created by Nicolas Dolinkue on 21/03/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    //ponemos el ? para no tener que dar un dato
    @objc dynamic var dateCreated: Date?
    
    //para realcionar con Category
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
