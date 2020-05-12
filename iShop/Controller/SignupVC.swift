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
    @IBOutlet var stackVerticalConstraint: NSLayoutConstraint!
    
    @IBOutlet var userFormStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.image = #imageLiteral(resourceName: "default")
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
                profileImageView.layer.cornerRadius = profileImageView.frame.height/2
    }
    
    @IBAction func signupClicked(_ sender: UIButton) {
        if let error = errorCheck() { AuthAlert(error) ; return}
        AuthClient.SignUp(email: "ij@k.com", password: passwordTextField.text!, completion: handleSignup(success:error:))
    }
    
    
    @IBAction func photoTapped(_ sender: UITapGestureRecognizer) {
        imagePicker.sharedInstance.imagePickerAlert(profileImageView, vc: self, completion: handlePhotoTapped(image:))
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
        let user = User(name: nameTextField.text!, email: emailTextField.text!, imageUrl: "imageUrl")
        databaseClient.shared.createUser(user: user, completion: handleCreateNewUser(success:error:))
    }
    
    func handleCreateNewUser(success:Bool,error:String?){
        success ? goToTabbar() : AuthAlert(error!)
    }
    
    func goToTabbar(){
        let image = profileImageView.image!
        let vc = storyboard!.instantiateViewController(identifier: "tabbar") as UITabBarController
        self.present(vc, animated: true) {
            DispatchQueue.global(qos: .background).async {
                StorageClient.createProfile(image)
            }
        }
    }
    
    func handlePhotoTapped(image:UIImage){
        self.profileImageView.image = image
    }
    
}
//MARK:- Keyboard show + hide functions
extension SignupVC {
    //MARK: Add Observers
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //MARK: Remove Observers
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    //MARK: Move stackView based on keybaord
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            
            //MARK: Get Keboard Y point on screen
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            
            //MARK: Get keyboard display time
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            
            //MARK: Set animations
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            let y = userFormStack.frame.origin.y + userFormStack.frame.height
            let x = y - endFrameY + 20
            
            //MARK: Animate stackView
            if endFrameY >= UIScreen.main.bounds.size.height {
                self.stackVerticalConstraint.constant = 0.0
            } else {
                self.stackVerticalConstraint.constant = -x
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}

