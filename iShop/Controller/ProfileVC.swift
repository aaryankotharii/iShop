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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.loadImage()
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        nameLabel.text = getName()
        // Do any additional setup after loading the view.
    }
}
