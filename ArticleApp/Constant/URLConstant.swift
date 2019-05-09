//
//  URLConstant.swift
//  ArticleApp
//
//  Created by Admin on 10/04/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation


//HostURL

let k_AUTHKEY     = "fRj2GIMScxmEfgQ8lYzDDvZ8mz1ku7Ek"
let k_APIHost     = "https://api.nytimes.com/svc/"
let k_APIMostViewedArticleList = "mostpopular/v2/viewed/1.json"
let k_APIMostSharedArticleList = "mostpopular/v2/shared/1.json"
let k_APIMostEmailedArticleList = "mostpopular/v2/emailed/7.json"
let k_APISearchArticleList = "search/v2/articlesearch.json"



struct RequestConstant {
    
    static let kGET  = "GET"
    static let kPUT  = "PUT"
    static let kPOST = "POST"
    
    static let kApplicationHeader        =  "application/x-www-form-urlencoded"
    static let kContent                  =  "Content-type"
    static let kJSONContent              =  "application/json; charset=UTF-8"
    static let kAccept                   =  "Accept"
    static let kAcceptType               =  "application/json"
    static let kContentLength            =  "Content-Length"
    static let kauthorization            =  "Authorization"
    static let kContentType              =  "application/json"
    
    static let pagelimit        = "limit"
    static let pageNo           = "page"
    static let kPageSize        =  20
    static let searchquery      = "q"
    static let apikey          = "api-key"
}
