//
//  ArticleList.swift
//  MediaApp
//
//  Created by FX on 2021/09/05.
//

import SwiftUI

struct ArticleList: View {
    @ObservedObject var microCMS = MicroCMSRequester()
    
    var body: some View {
        
        NavigationView {
            List(microCMS.articles) { article in
                NavigationLink(destination: ArticleDetail(contentId: article.id)) {
                    ArticleListRow(article: article)
                }
            }
        }.onAppear {
            microCMS.load()
        }
    }
}

struct ArticleList_Previews: PreviewProvider {
    static var previews: some View {
        ArticleList()
    }
}
