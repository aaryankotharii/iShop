//
//  ViewController.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var gifImageView: UIImageView!
    
    var loginstatus = UserDefaults.standard.bool(forKey: "login")

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perform(#selector(segue), with: nil, afterDelay: 1.0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @objc func segue(){
        switch loginstatus {
        case false:
            //TODO LOGOUT
            print("Signout successful")
            performSegue(withIdentifier: "tohome", sender: nil)
        case true:
            performSegue(withIdentifier: "tonav", sender: nil)
        }
        
    }
}
