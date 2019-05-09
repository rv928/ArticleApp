//
//  TagIDConstant.swift
//  ArticleApp
//
//  Created by Admin on 10/04/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

struct TagIDConstant {
    struct storyBoardIDs {
        
        static let storyboard = UIStoryboard(name: "Article", bundle: nil)
        
        static let kArticleCategoryViewController   = "ArticleCategoryViewController"
        static let kArticleListViewController   = "ArticleListViewController"
        static let kSearchArticleViewController   = "SearchArticleViewController"
    }
    
    struct cellIDs {
        static let kCategoryListCell = "CategoryListCell"
        static let kArticleCell      = "ArticleCell"
    }
    
    struct nibs {
        static let kGroupHeaderView = "GroupHeaderView"
    }
}
