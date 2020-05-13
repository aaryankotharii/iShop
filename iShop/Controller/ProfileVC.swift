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
    
    @IBOutlet var profileImageOutlineView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.loadImage()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageOutlineView.layer.cornerRadius = profileImageOutlineView.frame.height/2
        nameLabel.text = getName()
        
    }
    @IBAction func imageTapGesture(_ sender: UITapGestureRecognizer) {
        imagePicker.sharedInstance.imagePickerAlert(profileImageView, vc: self, completion: handlePhotoTapped(image:))
    }
    
    func handlePhotoTapped(image:UIImage){
        self.profileImageView.image = image
        profileImageView.saveImage()
        DispatchQueue.global(qos: .background).async {
                StorageClient.createProfile(image)  /// Send Profile Picture to Firebase Storage `in background Queue`
        }
    }
}
