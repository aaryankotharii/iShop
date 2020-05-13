//
//  ViewController.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import SwiftyGif

class ViewController: UIViewController {

    @IBOutlet var gifImageView: UIImageView!
    
    var loginstatus = UserDefaults.standard.bool(forKey: "login")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let gif = try UIImage(gifName: "launch.gif")
            gifImageView.setGifImage(gif)
        } catch {
            print(error)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.gifImageView.startAnimatingGif()
        perform(#selector(segue), with: nil, afterDelay: 1.0)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        gifImageView.stopAnimatingGif()
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
