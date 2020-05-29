//
//  SessionStore.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 28/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

class sessionStore : ObservableObject{
    
    let ref = Database.database().reference()
    
    var didChange = PassthroughSubject<sessionStore,Never>()
    
    @Published var session : User? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    @Published var userData : UserData? {
        didSet{
            self.didChange.send(self)
        }
    }
    
    var handle : AuthStateDidChangeListenerHandle?
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, email: user.email)
                self.getName(user: self.session!)
            } else {
                self.session = nil
            }
        })
    }
    
    func signUp(email:String,password:String, handler : @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signIn(email:String,password:String,handler : @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut(){
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print("Error signing out")
        }
    }
    
    func unbind(){
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
    
    func uploadUser(name : String, image : String,user : User, completion: @escaping (Error?)->()){
        let param = ["name":name,"email":user.email,"imageUrl":image]
        ref.child("users").child(user.uid).setValue(param) { (error, ref) in
            if let error = error{
                print("Uplaod failed")
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    //MARK:- Get User Name
    public func getName(user : User){
        print("gettin user")
        ref.child("users").child(user.uid).observe(.value) { (snapshot) in
             guard let dictionary = snapshot.value as?[String:AnyObject] else { return }
             if let name = dictionary["name"] as? String{
                self.userData = .init(user: user, name: name, image: "idk")
                print(name)
             }
         }
     }
}

struct User {
    var uid : String
    var email : String?
    
    init(uid:String,email:String?){
        self.uid = uid
        self.email = email
    }
}

struct UserData{
    var user : User
    var name :String
    var image : String
    
    init(user:User,name:String,image:String) {
        self.name = name
        self.image = image
        self.user = user
    }
}
