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
                print(AuthClient.handleError(error))
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
    
    class func handleError(_ error : Error) -> String{
        if let errorCode = AuthErrorCode(rawValue: error._code){
            switch errorCode {
            case .emailAlreadyInUse:
                return "already in use"
            case .invalidEmail:
                return "Please enter a valid email ID"
            case .userNotFound:
                return "No Account found. signup to continue"
            default:
                print("Error")
            }
        }
        return "please try again later"
    }
}
