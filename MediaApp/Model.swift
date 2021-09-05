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
