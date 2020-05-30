//
//  ImageLoader.swift
//  iShop SwiftUI
//
//  Created by Aaryan Kothari on 30/05/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import SwiftUI
import Combine

final class Loader: ObservableObject {
    
    var task: URLSessionDataTask!
    @Published var data: Data? = nil
    
    init(_ url: URL) {
        task = URLSession.shared.dataTask(with: url, completionHandler: { data, _, _ in
            DispatchQueue.main.async {
                self.data = data
            }
        })
        task.resume()
    }
    deinit {
        task.cancel()
    }
}

let placeholder = UIImage(systemName: "person.fill")!

struct AsyncImage: View {
    init(url: URL) {
        self.imageLoader = Loader(url)
    }
    
    @ObservedObject private var imageLoader: Loader
    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
    
    
    var body: some View {
        Image(uiImage: image ?? placeholder)
    }
}
