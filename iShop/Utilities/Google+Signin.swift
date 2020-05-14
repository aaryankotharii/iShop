//
//  Google+Signin.swift
//  iShop
//
//  Created by Aaryan Kothari on 13/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

//MARK:- SIGN IN WITH GOOGLE + FETCH USER DATA
extension HomeVC : GIDSignInDelegate{
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            switch error.localizedDescription {
            case "The user canceled the sign-in flow.": break
                //TODO remove blur of background
            default:
                print(error.localizedDescription)
            }
                return
            }
        
        guard let authentication = user.authentication else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
            
            let name = user.profile.name
            let email = user.profile.email
            let url = user.profile.imageURL(withDimension: 100)
            
            guard let uid = user.userID else { return }
            print("Sucessfully logged into firebase with Google!",uid)
            UserDefaults.standard.setValue(true, forKey: "login")
            UserDefaults.standard.setValue(name, forKey: "name")
            
            
            let user = User(name: name!, email: email!, imageUrl:  url!.absoluteString)
            databaseClient.shared.createUser(user: user) { (success, error) in
                if error != nil { print(error!) }
            }
            
           //Access the storyboard and fetch an instance of the view controller
            let storyboard = UIStoryboard(name: "Main", bundle: nil);
            let vc = storyboard.instantiateViewController(withIdentifier: "nav") as! UINavigationController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated:true, completion: nil)
        }
    }
}
