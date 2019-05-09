//
//  CategoryListCell.swift
//  ArticleApp
//
//  Created by Admin on 07/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

class CategoryListCell: UITableViewCell {

    @IBOutlet weak var itemNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCategoryDetails(currentCategory:String?) {
        self.itemNameLabel.text = currentCategory!
    }
}
