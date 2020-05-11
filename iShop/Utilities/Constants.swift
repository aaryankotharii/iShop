//
//  Constants.swift
//  iShop
//
//  Created by Aaryan Kothari on 11/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import Firebase

//MARK: -  function to get uid
internal func getUID() -> String {
    let uid = Auth.auth().currentUser?.uid
    return uid ?? "notFound"
}
