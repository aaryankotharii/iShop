//
//  FirebaseClient.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import FirebaseAuth

class AuthClient{
    
    class func Login(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error{
                completion(false,error)
                return
            }
            completion(true,nil)
        }
    }
    
    class func SignUp(email: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error{
                completion(false,error)
                return
            }
            completion(true,nil)
        }
    }
}
