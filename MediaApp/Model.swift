//
//  Model.swift
//  MediaApp
//
//  Created by FX on 2021/09/05.
//

import Foundation

struct Article: Identifiable, Equatable {
    var id: String
    var publishedAt: Date
    var title: String
    var imageURL: URL
    var contents: [Dictionary<String, Any>]
    
    static func == (lhs: Article, rhs: Article) -> Bool{
        lhs.id == rhs.id
    }
}

protocol ArticleContent {}
struct HeadingContent: ArticleContent {
    var text: String
}
    
struct ImageContent: ArticleContent {
    var imageUrl: URL
}
    
struct TextContent: ArticleContent {
    var text: String
}


class MicroCMSRequester: ObservableObject {
    @Published var articles = [Article]()
    
    @Published var article: Article? = nil
    private let iso8601DateFormatter = ISO8601DateFormatter()
    
    init() {
        iso8601DateFormatter.formatOptions.insert(.withFractionalSeconds)
    }
    
    func load() {
        var request = URLRequest(url: URL(string: "https://ios.microcms.io/api/v1/articles")!)
        
        request.setValue("5f3986b8-f85a-4a65-82f6-2c0e5dc4177e", forHTTPHeaderField: "X-API-KEY")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                let contents = object["contents"] as! Array<Dictionary<String, Any>>
                let articles = contents.map { (content) -> Article in
//                    let id = content["id"] as! String
//                    let title = content["title"] as! String
//                    let mainVisual = content["main_visual"] as! Dictionary<String, Any>
//                    let imageUrl = mainVisual["url"] as! String
//                    let contents = content["contents"] as! [Dictionary<String, Any>]
//                    let publishedAt = self.iso8601DateFormatter.date(from: content["publishedAt"] as! String)
                    return self.objectToArticle(object: content)
                }
                DispatchQueue.main.async {
                    self.articles = articles
                }
            } catch let e {
                print(e)
            }
        }.resume()
    }
    
    func loadDetail(contentId: String) {
        var request = URLRequest(url: URL(string: "https://ios-test.microcms-dev.net/api/v1/articles/\(contentId)")!)
        request.setValue("5f3986b8-f85a-4a65-82f6-2c0e5dc4177e", forHTTPHeaderField: "X-API-KEY")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any>
                let article = self.objectToArticle(object: object)
                DispatchQueue.main.async {
                    self.article = article
                }
            } catch let e {
                print(e)
            }
        }.resume()
    }
    
    func clearArticle() {
        self.article = nil
    }
    
    //共通化処理を追加
    private func objectToArticle(object: Dictionary<String, Any>) -> Article {
        let id = object["id"] as! String
        let title = object["title"] as! String
        let mainVisual = object["main_visual"] as! Dictionary<String, Any>
        let imageUrl = mainVisual["url"] as! String
        
        let contents = object["contents"] as! [Dictionary<String, Any>]
        
        //let rawContents = object["contents"] as! [Dictionary<String, Any>]
//        let contents = rawContents.map { content -> ArticleContent in
//            let fieldId = content["fieldID"] as! String
//            switch fieldId {
//            case "text":
//                return TextContent(text: content["text"] as! String)
//            case "heading":
//                return HeadingContent(text: content["text"] as! String)
//            case "image":
//                let image = content["image"] as! Dictionary<String, Any>
//                return ImageContent(imageUrl: URL(string: image["url"] as! String)!)
//            default:
//                return TextContent(text: "")
//            }
//        }
        let publishedAt = self.iso8601DateFormatter.date(from: object["publishedAt"] as! String)
        return Article(id: id, publishedAt: publishedAt!, title: title, imageURL: URL(string: imageUrl)!, contents: contents)
    }
}
