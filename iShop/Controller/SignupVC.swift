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
    @IBOutlet var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func signupClicked(_ sender: UIButton) {
        if let error = errorCheck() { AuthAlert(error) ; return}
        AuthClient.SignUp(email: "d@k.com", password: "123456", completion: handleSignup(success:error:))
    }
    
    
    //MARK:- Error Checking Function
    func errorCheck() -> String? {
        if nameTextField.text! == "" ||
            passwordTextField.text! == "" ||
            confirmPasswordTextField.text! == "" ||
            nameTextField.text! == ""
        {
            return "Name is missing."
        }
        else if !(passwordTextField.text == confirmPasswordTextField.text){
            return "Passwords do not match."
        }
        return nil
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
