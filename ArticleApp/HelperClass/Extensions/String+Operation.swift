//
//  String+Operation.swift
//  ArticleApp
//
//  Created by Admin on 10/04/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

extension String {
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    var isBlank:Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString.isEmpty
    }
    
    func removewhitespace() -> String {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString
    }
}
