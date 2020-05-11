//
//  DatabaseClient.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import FirebaseDatabase


class databaseClient{
    
    static let shared = databaseClient()
    let database = Database.database().reference()
    let myUID = getUID()
    
    //MARK: - Function to fill the user form
   public func createUser(user: User,completion: @escaping (Bool, Error?) -> ()) {
        // setValue with param = ["name": "yourName", ....] type
    self.database.child("users").child(myUID).setValue(user.param) { (error, ref) in
            if let error = error {
                completion(false,error)
                return
            }
            completion(true,nil)
        }
    }
}



