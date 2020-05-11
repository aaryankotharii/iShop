//
//  StorageClient.swift
//  iShop
//
//  Created by Aaryan Kothari on 12/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import FirebaseStorage


class StorageClient{
    
   class func createProfile(_ profileImageView: UIImageView){
            
        let uid = getUID()
        
        let imageName = NSUUID().uuidString
            
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
        if let profileImage = profileImageView.image,
                
                let uploadData = profileImage.jpegData(compressionQuality: 0.2){
                        
                    storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else {
                            
                        storageRef.downloadURL { (url, error) in
                            if let error = error {
                                print(error.localizedDescription)
                            }else{
                                databaseClient.shared.updateProfileImage(url: url?.absoluteString ?? "invalid") { (success) in
                                    print(success)
                            }
                        }
                    }
                }
            }
        }
    
}

}
