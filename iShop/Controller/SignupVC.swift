//
//  SignupVC.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

//TODO Disable signupButton

import UIKit

class SignupVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var confirmPasswordTextField: UITextField!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var stackVerticalConstraint: NSLayoutConstraint!
    @IBOutlet var userFormStack: UIStackView!
    @IBOutlet var signUpButton: UIButton!
    
    /// Value of StackView origin Y coordinate `used for textfield dynamic animation`
    var stackY : CGFloat!
    
    var bool : Bool = false
    
    //MARK: --- VIEW LIFECYCLE METHODS ---
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotifications()      /// ADD OBSERVERS `To Move StackView`
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()  /// REMOVE OBSERVERS    `To Free Memory`
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2   /// Maintains ProfileImageView to be a circle
    }
    
    //MARK: Initial Setup
    fileprivate func initialSetup() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.image = #imageLiteral(resourceName: "default")
        stackY = userFormStack.frame.origin.y
    }
    
    //MARK:- IBACTIONS
    @IBAction func signupClicked(_ sender: UIButton) {
        signUpButton.isEnabled = false
        if let error = errorCheck() { AuthAlert(error) ; return}
        AuthClient.SignUp(email: emailTextField.text!, password: passwordTextField.text!, completion: handleSignup(success:error:))
    }
    
    // ProfileImageView Tapped
    @IBAction func photoTapped(_ sender: UITapGestureRecognizer) {
        imagePicker.sharedInstance.imagePickerAlert(profileImageView, vc: self, completion: handlePhotoTapped(image:))
    }
    
    
    //MARK: Error Checking Function ( Checks Empty Textfields + Password matching )
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
        if !bool{
        if profileImageView.image == #imageLiteral(resourceName: "default"){
            bool = true
            return "You can change your profile picture by tapping on it. (optional)"
        }}
        return nil
    }
    
    //MARK:- Completion Handlers
    func handleSignup(success:Bool,error:String?){
        success ? handleSuccessSignUp() : AuthAlert(error ?? "Error")
    }
    
    func handleSuccessSignUp(){
        let user = User(name: nameTextField.text!, email: emailTextField.text!, imageUrl: "imageUrl")
        databaseClient.shared.createUser(user: user, completion: handleCreateNewUser(success:error:))
    }
    
    func handleCreateNewUser(success:Bool,error:String?){
        print("Sign up success")
        success ? goToTabbar() : AuthAlert(error!)
    }
    
    func handlePhotoTapped(image:UIImage){
        self.profileImageView.image = image
    }
    
    //MARK: --- NAVIGATION ---
    func goToTabbar(){
        let image = profileImageView.image!
        let vc = storyboard!.instantiateViewController(identifier: "nav") as UINavigationController
        profileImageView.saveImage()
        UserDefaults.standard.setValue(nameTextField.text!, forKey: "name")
        self.present(vc, animated: true) {
            DispatchQueue.global(qos: .background).async {
                StorageClient.createProfile(image)  /// Send Profile Picture to Firebase Storage `in background Queue`
            }
        }
    }
}

//MARK:- Keyboard show + hide functions
extension SignupVC {
    //MARK: Add Observers
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardisUp), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    //MARK: Remove Observers
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardisUp(notification: NSNotification){
        if let userInfo = notification.userInfo {
        
        //MARK: Get Keboard Y point on screen
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
            print("END FRAME IS ",endFrame)
        }
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
            
            // MARK: Get Keyboard Top Inset
            let stackBottomY = stackY + userFormStack.frame.height
            let KeyboardTopInset = stackBottomY - endFrameY + 20
            let screenHeight = UIScreen.main.bounds.size.height
            
            self.stackVerticalConstraint.constant = (endFrameY >= screenHeight) ? 0.0 : -KeyboardTopInset
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}

