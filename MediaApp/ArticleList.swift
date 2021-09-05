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
        List(microCMS.articles) {
            ArticleListRow(article: $0)
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
