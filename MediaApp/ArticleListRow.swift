//
//  ArticleListRow.swift
//  MediaApp
//
//  Created by FX on 2021/09/05.
//

import SwiftUI

struct ArticleListRow: View {
    var article: Article
    
    var body: some View {
        HStack {
            UrlImage(url: article.imageURL)
                .frame(width: 70, height: 50)
            VStack(alignment: HorizontalAlignment.leading) {
                Text(article.title)
                Text(article.publishedAt.description)
            }
            Spacer()
        }.onAppear {
            
        }
    }
}

struct ArticleListRow_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListRow(article: Article(id: "9wq0y1yoh", publishedAt: Date(), title: "Swift", imageURL: URL(string: "https://images.microcms-assets.io/assets/38fe1cc28dc7457ba42302e2cc3b4e07/c44b14626d694b23b5e728e8301312c7/images.png")!, contents: []))
    }
}
