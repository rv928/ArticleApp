//
//  ArticleViewModel.swift
//  ArticleApp
//
//  Created by Admin on 08/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    
    let title: String?
    let publishedDate: String?
    
    init(article: Article) {
        self.title = article.title!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: article.published_date!)
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let dateString:String = dateFormatter.string(from: date!)
        
        self.publishedDate = dateString
    }
}
