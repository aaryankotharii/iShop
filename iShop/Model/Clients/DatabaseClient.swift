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
    public func createUser(user: User,completion: @escaping (Bool, String?) -> ()) {
        // setValue with param = ["name": "yourName", ....] type
        self.database.child("users").child(myUID).setValue(user.param) { (error, ref) in
            if let error = error{
                let errorDescription = AuthClient.handleError(error)
                completion(false,errorDescription)
                return
            }
            completion(true,nil)
        }
    }
    
    //MARK:- Update profile picture
    public func updateProfileImage(url: String,completion:@escaping (Bool) -> ()) {
        let ref = database.child("users").child(getUID())
        ref.updateChildValues(["imageUrl":url]) { (error, ref) in
            if let _ = error{ completion(false) ;  return }
            completion(true)
        }
    }
    
    //MARK:- Get profileImageUrl ( To persist Image )
    public func getProfileImageUrl(completion : @escaping (String?)->()){
        let ref = database.child("users").child(getUID())
        ref.observe(.value) { (snapshot) in
            guard let dictionary = snapshot.value as?[String:AnyObject] else { return }
            
            if let url = dictionary["imageUrl"]{completion((url as! String)) }
            else {
                completion(nil)
            }
        }
    }
    
    //MARK:- Get User Name
    public func getName(completion : @escaping (String?)->()){
        let ref = database.child("users").child(getUID())
        ref.observe(.value) { (snapshot) in
            guard let dictionary = snapshot.value as?[String:AnyObject] else { return }
            
            if let name = dictionary["name"]{completion((name as! String)) }
            else {
                completion(nil)
            }
        }
    }
}



