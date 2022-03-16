//
//  Items.swift
//  Todoey
//
//  Created by Nicolas Dolinkue on 15/03/2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation



class Item: Encodable,Decodable {
    var title: String = ""
    var done: Bool = false
    
}
