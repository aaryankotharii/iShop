//
//  User.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

struct User {
    var name : String
    var email : String
    var imageUrl : String
    
    var param : [String:Any]{
        return ["name":String(name),"email":email,"imageUrl":imageUrl]
    }
}
