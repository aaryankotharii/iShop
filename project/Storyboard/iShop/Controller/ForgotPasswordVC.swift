//
//  ForgotPasswordVC.swift
//  iShop
//
//  Created by Aaryan Kothari on 15/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func sendLinkClicked(_ sender: Any) {
        if let error = errorCheck() { AuthAlert(error) ; return}
        AuthClient.forgotPassword(email: emailTextField.text!, completion: handleForgotPassword(success:error:))
    }
    
    func handleForgotPassword(success:Bool,error:String?){
        if success {
            successLAert("Verification Link sent. please check your email")
            emailTextField.text = ""
        } else {
            AuthAlert(error ?? "Error")
        }
    }
    
    func errorCheck()->String?{
        let email = emailTextField.text
        if let email = email  {
            if email.isEmpty{
                return "Please Fill in your email"
            }
        }
        return nil
    }
}
