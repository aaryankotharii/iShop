//
//  SignupVC.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signupClicked(_ sender: UIButton) {
        AuthClient.SignUp(email: "a@k.com", password: "123456", completion: handleSignup(success:error:))
    }
    
    func handleSignup(success:Bool,error:String?){
        success ? handleSuccessSignUp() : AuthAlert(error ?? "Error")
    }
    
    func handleSuccessSignUp(){
        let user = User(name: "Aaryan", email: "a@k.com", imageUrl: "imageUrl")
        databaseClient.shared.createUser(user: user, completion: handleCreateNewUser(success:error:))
    }
    
    func handleCreateNewUser(success:Bool,error:String?){
        success ? goToTabbar() : AuthAlert(error!)
    }
    
    func goToTabbar(){
        
    }
    
    
}
