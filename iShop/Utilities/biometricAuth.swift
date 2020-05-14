//
//  biometricAuth.swift
//  iShop
//
//  Created by Aaryan Kothari on 14/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import LocalAuthentication


class BiometricAuth {
    class func Authenticate(completion: @escaping (Bool,NSError?)->()){
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Identify yourself"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, error) in
                if let error = error {
                    print(error.localizedDescription)
                    completion(false,error as NSError)
                } else {
                   completion(true,nil)
                }
            }
        } else {
            completion(false,nil)
        }
    }
}
