//
//  ArticleDetail.swift
//  MediaApp
//
//  Created by FX on 2021/09/06.
//

import SwiftUI

struct ArticleDetail: View {
    var contentId: String
    
    @ObservedObject var microCMS = MicroCMSRequester()
    
    init(contentId: String) {
        self.contentId = contentId
    }
    
    var body: some View {
        
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                if let article = microCMS.article {
                    //main_visual
                    UrlImage(url: article.imageURL)
                        .frame(height: 200)
                    VStack(alignment: .leading) {
                        //title
                        Text(microCMS.article?.title ?? "")
                            .font(.title)
                        Divider()
                        //header
                        ForEach(0 ..< article.contents.count) { num in
                            let content = article.contents[num]
                            if let heading = content as? HeadingContent {
                                Text(heading.text)
                                    .font(.title2)
                                    .padding(.top, 10)
                            }else if let text = content as? TextContent {
                                Text(text.text).padding(.top, 10)
                            }else if let image = content as? ImageContent {
                                UrlImage(url: image.imageUrl)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        Text(contentId)
    }
}

struct ArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetail(contentId: "my-first-content")
    }
}
