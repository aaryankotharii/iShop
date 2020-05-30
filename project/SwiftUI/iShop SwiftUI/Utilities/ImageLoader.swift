//
//  ImageLoader.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 30/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI
import Combine


class ImageLoader : ObservableObject {
    
    var downloadedImage : UIImage?
    let didChange = PassthroughSubject<ImageLoader?,Never>()
    
    func load(url:String){
        guard let imageUrl = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error ) in
            guard let data = data , error == nil else {
                DispatchQueue.main.async {
                    self.didChange.send(nil)
                }
                return
            }
            
            self.downloadedImage = UIImage(data: data)
            DispatchQueue.main.async {
                self.didChange.send(self)
            }
        }
    }
}
