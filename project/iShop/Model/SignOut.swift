//
//  SignOut.swift
//  iShop
//
//  Created by Aaryan Kothari on 14/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import Firebase
import GoogleSignIn

//MARK: - SIGNOUT Extension

extension ProfileVC{
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            // Deleting all user Defaults
            if let appDomain = Bundle.main.bundleIdentifier {
                UserDefaults.standard.removePersistentDomain(forName: appDomain)
            }
            
            // try signout
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
            print("SIGN OUT")
            
            // return to home
            let vc = storyboard?.instantiateViewController(withIdentifier: "home") as! UINavigationController
            self.present(vc, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
