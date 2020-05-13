//
//  Constants.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import Firebase

let storyboard = UIStoryboard(name: "Main", bundle: nil)

var profilePicture : UIImage?{
    return UserDefaults.standard.value(forKey: "image") as? UIImage
}


//MARK: -  function to get uid
internal func getName() -> String {
    let name = UserDefaults.standard.value(forKey: "name") as? String
    return name ?? ""
}


//MARK: -  function to get uid
internal func getUID() -> String {
    let uid = Auth.auth().currentUser?.uid
    return uid ?? "notFound"
}
