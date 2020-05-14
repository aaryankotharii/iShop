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

    @IBOutlet var unlcokButton: UIButton!
    
    @IBOutlet var lockedPhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue(false, forKey: "auth")
        lockedPhoto.isHidden = true
        unlcokButton.isHidden = true
        switch BiometricAuth.shared.biometricType {
        case .faceID:
            unlcokButton.setTitle("Use FaceID", for: .normal)
        case .touchID:
            unlcokButton.setTitle("User TouchID", for: .normal)
        default:
            AuthAlert("Please enable biometric Auth")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        BiometricAuth.shared.Authenticate(completion: handleAuth(success:error:))
    }
    
    @IBAction func UseFaceIdTapped(_ sender: UIButton) {
        BiometricAuth.shared.Authenticate(completion: handleAuth(success:error:))
    }
    
    func handleAuth(success:Bool,error:NSError?){
        if success{
            UserDefaults.standard.setValue(true, forKey: "auth")
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)   /// Back to VC
            }
        }
        else {
            if let error = error {
                switch error.code {
            case -2:
                DispatchQueue.main.async {
                    self.lockedPhoto.isHidden = false
                    self.unlcokButton.isHidden = false
                }
            default:
                print(error)
            }
        }
        }
    }
}
