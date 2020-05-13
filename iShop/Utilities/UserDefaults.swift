//
//  Image+Saving.swift
//  iShop
//
//  Created by Aaryan Kothari on 13/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView{
        
    func saveImage(){
        let imageData = self.image?.jpegData(compressionQuality: 1.0)
        UserDefaults.standard.set(imageData, forKey: "image")
    }
    
    func loadImage(){

        if let imagedata = UserDefaults.standard.value(forKey: "image") as? Data{
            self.image = UIImage(data: imagedata)
        }
    }
}




