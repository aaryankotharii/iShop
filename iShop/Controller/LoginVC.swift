//
//  LoginVC.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func loginClicked(_ sender: UIButton) {
        AuthClient.Login(email: emailTextField.text!, password: passwordTextField.text!, completion: handleLogin(success:error:))
    }
    
    func handleLogin(success:Bool,error:String?){
        if let error = errorCheck() { AuthAlert(error) ; return}
        success ? handleSuccessLogin() : AuthAlert(error ?? "Error")
    }
    
    func handleSuccessLogin(){
        UIDevice.validVibrate()
        print("YAY LOGGED IN")
    }
    
    //MARK:- Error Checking Function
    func errorCheck() -> String? {
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if email == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please Fill in all the fields"
        }
        if emailTextField.text == nil || passwordTextField.text == nil {
            return "Please Fill in all the fields"
        }
        return nil
    }
}
