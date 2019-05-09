//
//  ArticleList.swift
//  ArticleApp
//
//  Created by Admin on 07/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation


struct Article : Codable {
    let url : String?
    let type : String?
    let title : String?
    let published_date : String?
    let source : String?
    let id : Int?
    let asset_id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case url = "url"
        case type = "type"
        case title = "title"
        case published_date = "published_date"
        case source = "source"
        case id = "id"
        case asset_id = "asset_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        published_date = try values.decodeIfPresent(String.self, forKey: .published_date)
        source = try values.decodeIfPresent(String.self, forKey: .source)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        asset_id = try values.decodeIfPresent(Int.self, forKey: .asset_id)
    }
}

