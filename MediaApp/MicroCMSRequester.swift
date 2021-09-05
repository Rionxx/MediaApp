//
//  MicroCMSRequester.swift
//  MediaApp
//
//  Created by FX on 2021/09/05.
//

import Foundation


class MicroCMSRequester: ObservableObject {
    @Published var articles = [Article]()
    private let iso8601DateFormatter = ISO8601DateFormatter()
    
    init() {
        iso8601DateFormatter.formatOptions.insert(.withFractionalSeconds)
    }
    
    func load() {
        var request = URLRequest(url: URL(string: "https://ios.microcms.io/api/v1/articles")!)
        
        request.setValue("XXXXXXXXX-XXXXXXXXXX", forHTTPHeaderField: "X-API-KEY")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                let contents = object["contents"] as! Array<Dictionary<String, Any>>
                let articles = contents.map { (content) -> Article in
                    let id = content["id"] as! String
                    let title = content["title"] as! String
                    let mainVisual = content["main_visual"] as! Dictionary<String, Any>
                    let imageUrl = mainVisual["url"] as! String
                    let contents = content["contents"] as! [Dictionary<String, Any>]
                    let publishedAt = self.iso8601DateFormatter.date(from: content["publishedAt"] as! String)
                    return Article(id: id, publishedAt: publishedAt!, title: title, imageURL: URL(string: imageUrl)!, contents: contents)
                }
                DispatchQueue.main.async {
                    self.articles = articles
                }
            } catch let e {
                print(e)
            }
        }.resume()
    }
}
