//
//  URLImage.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 30/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI

struct URLImage: View {
    @ObservedObject private var imageLoader = ImageLoader()
    
    var placeholder : Image
    
    init(url:String,placeholder:Image = Image(systemName: "person.fill")) {
        self.placeholder = placeholder
        self.imageLoader.load(url: url)
    }
    
    var body: some View {
        if let uiimage = self.imageLoader.downloadedImage {
            return Image(uiImage: uiimage)
        } else {
            return placeholder
        }
    }
}

struct URLImage_Previews: PreviewProvider {
    static var previews: some View {
        URLImage(url: "")
    }
}
