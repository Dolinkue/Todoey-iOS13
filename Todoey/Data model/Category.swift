//
//  Category.swift
//  Todoey
//
//  Created by Nicolas Dolinkue on 21/03/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    // la relacion que hay entre item y categort, con list se genera la relacion
    let items = List<Item>()
    
    
    
}

