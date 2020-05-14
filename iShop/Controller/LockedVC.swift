//
//  LockedVC.swift
//  iShop
//
//  Created by Aaryan Kothari on 14/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

//MARK:- Present When auth is false

class LockedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(false, forKey: "auth")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BiometricAuth.Authenticate(completion: handleAuth(success:error:))
    }
    
    @IBAction func UseFaceIdTapped(_ sender: UIButton) {
        BiometricAuth.Authenticate(completion: handleAuth(success:error:))
    }
    
    func handleAuth(success:Bool,error:NSError?){
        if success{
            UserDefaults.standard.setValue(true, forKey: "auth")
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)   /// Back to VC
            }
        }
        else {
            print("no success")
        }
    }
}
