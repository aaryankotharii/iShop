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

    func load(url:String?){
        guard let url = url , let imageUrl = URL(string: url) else { return }

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
        }.resume()
    }
}

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
        .resizable()
    }
}
