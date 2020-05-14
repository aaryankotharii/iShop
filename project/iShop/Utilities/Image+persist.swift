//
//  Image+Persist.swift
//  iShop
//
//  Created by Aaryan Kothari on 13/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView{
    
    //MARK:- Save Image as Userdefault
    func saveImage(){
        let imageData = self.image?.jpegData(compressionQuality: 1.0)
        UserDefaults.standard.set(imageData, forKey: "image")
    }
    
    // download image if not persisted
    func loadImage(){
        if let imagedata = UserDefaults.standard.value(forKey: "image") as? Data{
            self.image = UIImage(data: imagedata)
        } else {
            databaseClient.shared.getProfileImageUrl{ url in
                if let url = url {
                    self.loadImageUsingCacheWithUrlString(urlString: url)
                }
            }
        }
    }
    
    
    // Download and cache image from url
    func loadImageUsingCacheWithUrlString(urlString : String){
        self.image = nil
        
        //check cache for image
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            self.image = cachedImage
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            }
            else{
                DispatchQueue.main.async {
                    if  let downloadedImage = UIImage(data: data!) {
                        
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        
                        self.image = downloadedImage
                        
                        /// Download Image and set as `userDefault`
                        let imageData = downloadedImage.jpegData(compressionQuality: 1.0)
                        UserDefaults.standard.set(imageData, forKey: "image")
                    }
                }
            }
        }.resume()
    }
    
}




