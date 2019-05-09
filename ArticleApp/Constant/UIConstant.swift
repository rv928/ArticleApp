//
//  UIConstant.swift
//  ArticleApp
//
//  Created by Admin on 10/04/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

struct UIConstant  {
    
    static let appColor = "#FF6666"
    static let appTextColor = "#000000"
    static let navTextColor = "#FFFFFF"
    static let tagBgColor = "#9ACD32"
    static let tagTextColor = "#FFFFFF"
    
    struct ProgressHUD {
        static let bgColor = "#FFFFFF"
        static let TextColor = "#FF6666"
    }
    
    struct Images {
        static let searchIcon = "icon-search"
        static let backIcon = "icon-back"
    }
    
    struct Fonts {
        
        static func FONT_HELVETICA_BOLD(_ _size:CGFloat) -> UIFont {
            let font: UIFont = UIFont(name: "Helvetica-Bold", size: _size)!
            return font
        }
        
        static func FONT_HELVETICA_REGULAR(_ _size:CGFloat) -> UIFont {
            let font: UIFont = UIFont(name: "Helvetica", size: _size)!
            return font
        }
    }
}
