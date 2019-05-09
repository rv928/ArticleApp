//
//  SearchArticleList.swift
//  ArticleApp
//
//  Created by Admin on 08/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

struct SearchArticleList : Codable {
    let docs : [SearchArticle]?
    let meta : Meta?
    
    enum CodingKeys: String, CodingKey {
        
        case docs = "docs"
        case meta = "meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docs = try values.decodeIfPresent([SearchArticle].self, forKey: .docs)
        meta = try values.decodeIfPresent(Meta.self, forKey: .meta)
    }
    
}


struct Meta : Codable {
    let hits : Int?
    let offset : Int?
    let time : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case hits = "hits"
        case offset = "offset"
        case time = "time"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hits = try values.decodeIfPresent(Int.self, forKey: .hits)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        time = try values.decodeIfPresent(Int.self, forKey: .time)
    }
    
}


struct SearchArticle : Codable {
    let web_url : String?
    let multimedia : [Multimedia]?
    let headline : Headline?
    let pub_date : String?
    let section_name : String?
    let byline : Byline?
    
    enum CodingKeys: String, CodingKey {
        
        case web_url = "web_url"
        case multimedia = "multimedia"
        case headline = "headline"
        case pub_date = "pub_date"
        case section_name = "section_name"
        case byline = "byline"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        web_url = try values.decodeIfPresent(String.self, forKey: .web_url)
        multimedia = try values.decodeIfPresent([Multimedia].self, forKey: .multimedia)
        headline = try values.decodeIfPresent(Headline.self, forKey: .headline)
        pub_date = try values.decodeIfPresent(String.self, forKey: .pub_date)
        section_name = try values.decodeIfPresent(String.self, forKey: .section_name)
        byline = try values.decodeIfPresent(Byline.self, forKey: .byline)
    }
    
}


struct Multimedia : Codable {
    let rank : Int?
    let subtype : String?
    let caption : String?
    let credit : String?
    let type : String?
    let url : String?
    let height : Int?
    let width : Int?
    let subType : String?
    let crop_name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case rank = "rank"
        case subtype = "subtype"
        case caption = "caption"
        case credit = "credit"
        case type = "type"
        case url = "url"
        case height = "height"
        case width = "width"
        case subType = "subType"
        case crop_name = "crop_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rank = try values.decodeIfPresent(Int.self, forKey: .rank)
        subtype = try values.decodeIfPresent(String.self, forKey: .subtype)
        caption = try values.decodeIfPresent(String.self, forKey: .caption)
        credit = try values.decodeIfPresent(String.self, forKey: .credit)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        subType = try values.decodeIfPresent(String.self, forKey: .subType)
        crop_name = try values.decodeIfPresent(String.self, forKey: .crop_name)
    }
    
}

struct Headline : Codable {
    let main : String?
    let kicker : String?
    let content_kicker : String?
    let print_headline : String?
    let name : String?
    let seo : String?
    let sub : String?
    
    enum CodingKeys: String, CodingKey {
        
        case main = "main"
        case kicker = "kicker"
        case content_kicker = "content_kicker"
        case print_headline = "print_headline"
        case name = "name"
        case seo = "seo"
        case sub = "sub"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        main = try values.decodeIfPresent(String.self, forKey: .main)
        kicker = try values.decodeIfPresent(String.self, forKey: .kicker)
        content_kicker = try values.decodeIfPresent(String.self, forKey: .content_kicker)
        print_headline = try values.decodeIfPresent(String.self, forKey: .print_headline)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        seo = try values.decodeIfPresent(String.self, forKey: .seo)
        sub = try values.decodeIfPresent(String.self, forKey: .sub)
    }
    
}


struct Byline : Codable {
    let original : String?
    let organization : String?
    
    enum CodingKeys: String, CodingKey {
        
        case original = "original"
        case organization = "organization"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        original = try values.decodeIfPresent(String.self, forKey: .original)
        organization = try values.decodeIfPresent(String.self, forKey: .organization)
    }
    
}
