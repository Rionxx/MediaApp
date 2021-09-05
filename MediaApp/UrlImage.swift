//
//  UrlImage.swift
//  MediaApp
//
//  Created by FX on 2021/09/05.
//

import SwiftUI

struct UrlImage: View {
    @ObservedObject private var requester = ImageRequester()
    
    var url: URL
    var body: some View {
        Image(uiImage: requester.image)
            .resizable()
            .onAppear {
                requester.load(url: url)
            }
    }
}

private class ImageRequester: ObservableObject {
    @Published var image: UIImage = UIImage()
    
    init() {}
    
    func load(url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let imageData = data, let networkImage = UIImage(data: imageData) else {
                return
            }
            DispatchQueue.main.async {
                self.image = networkImage
            }
        }).resume()
    }
}

//struct UrlImage_Previews: PreviewProvider {
//    static var previews: some View {
//        UrlImage()
//    }
//}
