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
    
    //MARK:- Signin user using email + password
    class func Login(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error{
                let errorDescription = AuthClient.handleError(error)
                completion(false,errorDescription)
                return
            }
            UserDefaults.standard.setValue(true, forKey: "login")
            completion(true,nil)
        }
    }
    
    //MARK:- Sigup User using email + password
    class func SignUp(email: String, password: String, completion: @escaping (Bool, String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error{
                let errorDescription = AuthClient.handleError(error)
                completion(false,errorDescription)
                return
            }
            UserDefaults.standard.setValue(true, forKey: "login")
            completion(true,nil)
        }
    }
    
    //MARK:- Handle Errors
    class func handleError(_ error : Error) -> String{
        if let errorCode = AuthErrorCode(rawValue: error._code){
            switch errorCode {
            case .emailAlreadyInUse:
                return "user exists! please Login"
            case .invalidEmail:
                return "Please enter a valid email ID"
            case .userNotFound:
                return "No Account found. signup to continue"
            case .networkError:
                return "No internet"
            case .wrongPassword:
                return "Password invalid"
            case .weakPassword:
                return "Password should have minimum 6 characters"
            default:
                print("Error")
            }
        }
        return "please try again later"
    }
}
