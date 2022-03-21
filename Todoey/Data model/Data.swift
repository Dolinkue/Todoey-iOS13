//
//  Data.swift
//  Todoey
//
//  Created by Nicolas Dolinkue on 20/03/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    // dynamic significa que modifica en tiempo real los cambios
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}

