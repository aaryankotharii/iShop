//
//  ProfileVC.swift
//  iShop
//
//  Created by Aaryan Kothari on 13/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var enableBioAuthLabel: UILabel!
    
    @IBOutlet var bioAuthToggle: UISwitch!
    
    var initialImage : UIImage!
    
    @IBOutlet var profileImageOutlineView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.loadImage()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageOutlineView.layer.cornerRadius = profileImageOutlineView.frame.height/2
        nameLabel.text = getName()
        enableBioAuthLabel.text = "Enable " + (BiometricAuth.shared.biometricTypeString)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        profileImageOutlineView.rotate360Degrees()
        initialImage = profileImageView.image
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        profileImageOutlineView.layer.removeAllAnimations()
    }
    
    @IBAction func imageTapGesture(_ sender: UITapGestureRecognizer) {
        imagePicker.sharedInstance.imagePickerAlert(profileImageView, vc: self, completion: handlePhotoTapped(image:))
    }
    @IBAction func logoutClicked(_ sender: Any) {
        signOut()
    }
    
    @IBAction func toggleSwitched(_ sender: UISwitch) {
        if sender.isOn{
            UserDefaults.standard.set(true, forKey: "bio")
        } else {
            UserDefaults.standard.set(false, forKey: "bio")
        }
    }
    
    func setUpToggle(){
        if let bool = UserDefaults.standard.value(forKey: "bio") as? Bool {
            bioAuthToggle.setOn(bool, animated: false)
        } else {
            bioAuthToggle.setOn(false, animated: false)
        }
    }
    
    
    
    func handlePhotoTapped(image:UIImage){
        self.profileImageView.image = image
        profileImageView.saveImage()
        DispatchQueue.global(qos: .background).async {
                StorageClient.createProfile(image)  /// Send Profile Picture to Firebase Storage `in background Queue`
        }
        if image != initialImage {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
            self.dismiss(animated: true, completion: nil) }
    }
    
}

extension UIView {
    func rotate360Degrees() {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 1
        rotateAnimation.repeatCount=Float.infinity
        self.layer.add(rotateAnimation, forKey: nil)
    }
}
