//
//  Alerts+functions.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import SystemConfiguration

extension UIViewController {
    //MARK:- ALERT fucntion for error display
    internal func AuthAlert(_ message:String, completion: (() -> Void)? = nil){
        UIDevice.invalidVibrate()
        let title = "Uh Oh 🙁"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
    //MARK: - ALERT function for network connection
    internal func networkErrorAlert(title : String) {
        // Vibrates on errors
        UIDevice.invalidVibrate()
        let alert = UIAlertController(title: title, message: "No internet connection available.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            let settingsUrl = NSURL(string: UIApplication.openSettingsURLString)
            if let url = settingsUrl {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            }
        })
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK:- ALERT fucntion for success display
    internal func successLAert(_ message:String, completion: (() -> Void)? = nil){
        UIDevice.validVibrate()
        let title = "Yay 😄"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}


