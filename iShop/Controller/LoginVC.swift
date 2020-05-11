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
        AuthClient.Login(email: "a@k.com", password: "123456", completion: handleLogin(success:error:))
    }
    
    func handleLogin(success:Bool,error:String?){
        success ? handleSuccessLogin() : AuthAlert(error ?? "Error")
    }
    
    func handleSuccessLogin(){
        UIDevice.validVibrate()
        print("YAY LOGGED IN")
    }
}
