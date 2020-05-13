//
//  HomeVC.swift
//  iShop
//
//  Created by Aaryan Kothari on 13/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var stackYAnchor: NSLayoutConstraint!
    
    @IBOutlet var loginStack: UIStackView!
    var stackY : CGFloat!
    var stackBottomY: CGFloat!
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToKeyboardNotifications()
        hideKeyboardWhenTappedAround()
        stackY = loginStack.frame.origin.y
        stackBottomY = stackY + loginStack.frame.height

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeFromKeyboardNotifications()  /// REMOVE OBSERVERS    `To Free Memory`
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
