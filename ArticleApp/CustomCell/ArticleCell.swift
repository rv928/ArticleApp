//
//  ArticleCell.swift
//  ArticleApp
//
//  Created by Admin on 07/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleNameLabel: UILabel!
    @IBOutlet weak var dateLabel: AttributedLabel!

    var articleViewModel: ArticleViewModel!{
        didSet {
            self.articleNameLabel.text = articleViewModel.title!
            self.dateLabel.setAttributedTextColor(leadingText: "Published Date : ", trailingText: articleViewModel.publishedDate!)
        }
    }
    
    var searcharticleViewModel: SearchArticleViewModel!{
        didSet {
            self.articleNameLabel.text = searcharticleViewModel.title!
            self.dateLabel.setAttributedTextColor(leadingText: "Published Date : ", trailingText: searcharticleViewModel.publishedDate!)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setArticleDetails(objArticle:SearchArticle?) {
        self.articleNameLabel.text = objArticle?.headline?.main!
        self.dateLabel.setAttributedTextColor(leadingText: "Published Date : ", trailingText: "14/05/19")
    }
}
