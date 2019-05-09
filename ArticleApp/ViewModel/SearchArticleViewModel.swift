//
//  SearchArticleViewModel.swift
//  ArticleApp
//
//  Created by Admin on 08/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

struct SearchArticleViewModel {
    
    let title: String?
    let publishedDate: String?
    
    init(article: SearchArticle) {
        self.title = article.headline?.main!
      
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "dd/MM/YYYY"
        let dateStart = formatter.date(from: "\(String(describing: article.pub_date!))")
        let strStart = formatter2.string(from: dateStart!)
        self.publishedDate = strStart
    }
}
