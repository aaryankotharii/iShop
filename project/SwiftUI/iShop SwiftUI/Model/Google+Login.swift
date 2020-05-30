//
//  Google+Login.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 30/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//


import SwiftUI
import GoogleSignIn
import Firebase

struct google : UIViewRepresentable {
    
    func makeUIView(context: Context) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .light
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: Context) {
        
    }
}

extension AppDelegate : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        print(error.localizedDescription)
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let result = result else { return }
            let user = result.user
            let name = user.displayName ?? ""
            let email = user.email ?? ""
            let uid = user.uid
            let imageUrl = user.photoURL?.absoluteString ?? ""
            let userData = User(uid: uid, email: email)
            sessionStore().uploadUser(name: name, image: imageUrl, user: userData) { (error) in
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
