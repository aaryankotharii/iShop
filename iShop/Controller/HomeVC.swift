//
//  HomeVC.swift
//  iShop
//
//  Created by Aaryan Kothari on 13/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class HomeVC: UIViewController {
    
    @IBOutlet var stackYAnchor: NSLayoutConstraint!
    
    @IBOutlet var loginStack: UIStackView!
    
    
    @IBOutlet var emailTextField: UITextField!
    
    
    @IBOutlet var passwordTextField: UITextField!
    
    var stackY : CGFloat!
    var stackBottomY: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()  /// REMOVE OBSERVERS    `To Free Memory`
    }
    
    fileprivate func initialSetup() {
        UserDefaults.standard.set(nil, forKey: "image")
        hideKeyboardWhenTappedAround()
        subscribeToKeyboardNotifications()
        stackY = loginStack.frame.origin.y
        stackBottomY = stackY + loginStack.frame.height
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
    }
    
    
    
    @IBAction func loginClicked(_ sender: UIButton) {
        if let error = errorCheck() { AuthAlert(error) ; return}
        AuthClient.Login(email: emailTextField.text!, password: passwordTextField.text!, completion: handleLogin(success:error:))
    }
    
    @IBAction func googleSigninClicked(_ sender: UIButton) {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    func handleLogin(success:Bool,error:String?){
        success ? handleSuccessLogin() : AuthAlert(error ?? "Error")
    }
    
    func handleSuccessLogin(){
        UIDevice.validVibrate()
        print("YAY LOGGED IN")
        goToTabbar()
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
    
    func goToTabbar(){
        let vc = storyboard!.instantiateViewController(identifier: "nav") as UINavigationController
        self.present(vc, animated: true) {
            print("preszen")
        }
    }
    
}


//MARK:- Keyboard show + hide functions
extension HomeVC {
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
        print(stackYAnchor.constant)
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
            
            let KeyboardTopInset = stackBottomY - endFrameY + 20
            let screenHeight = UIScreen.main.bounds.size.height
            
            self.stackYAnchor.constant = (endFrameY >= screenHeight) ? 0.0 : -KeyboardTopInset
            
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
}
