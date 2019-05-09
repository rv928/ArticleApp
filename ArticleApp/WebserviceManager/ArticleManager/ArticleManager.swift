//
//  ArticleManager.swift
//  ArticleApp
//
//  Created by Admin on 07/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

// Singleton for User List webservices

class ArticleManager {
    
    static let manage:ArticleManager = {
        let instance = ArticleManager()
        return instance
    }()
    
    private init() {}

    
    /*
     * This method will fetch Most Viewed articles from webservice
     */

    func fetchMostViewedArticles(vc:UIViewController?,completion: @escaping (_ articleList:[Article]?) -> Void) {
        
        SharedClass.sharedInstance.showProgressHUD(true)
        
        //Sample URL
        //https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=yourkey

        
        RequestManager.manager.fetchData(vc,dictparamters:nil, APIName: k_APIHost + k_APIMostViewedArticleList,HTTPType:"GET",completion: { (responseDictionary:Dictionary<String,Any>?,responseString:String?) -> Void in
            
            SharedClass.sharedInstance.showProgressHUD(false)
            var articleArray:Array<Any>?  = Array()
            articleArray = responseDictionary?["results"] as? Array<Any> ?? nil
            
            var objArticleList:[Article]?
            if articleArray != nil {
                let currentArticleList = try! DictionaryDecoder().decode([Article].self, from: articleArray!)
                objArticleList = currentArticleList
                completion(objArticleList)
            }
            else {
                DispatchQueue.main.async {
                    SharedAlert.alert.displayAlertMessage(viewController: vc, strMessage: MessageConstant.validationMessage.NO_CONTENT, buttonTitle: "OK")
                }
                completion(nil)
            }
        })
    }
    
    
    /*
     * This method will fetch Most Shared articles from webservice
     */
    
    func fetchMostSharedArticles(vc:UIViewController?,completion: @escaping (_ articleList:[Article]?) -> Void) {
        
        SharedClass.sharedInstance.showProgressHUD(true)
        
        //Sample URL
        //https://api.nytimes.com/svc/mostpopular/v2/shared/1.json?api-key=yourkey
        
        
        RequestManager.manager.fetchData(vc,dictparamters:nil, APIName: k_APIHost + k_APIMostSharedArticleList,HTTPType:"GET",completion: { (responseDictionary:Dictionary<String,Any>?,responseString:String?) -> Void in
            
            SharedClass.sharedInstance.showProgressHUD(false)
            var articleArray:Array<Any>?  = Array()
            articleArray = responseDictionary?["results"] as? Array<Any> ?? nil
            
            var objArticleList:[Article]?
            if articleArray != nil {
                let currentArticleList = try! DictionaryDecoder().decode([Article].self, from: articleArray!)
                objArticleList = currentArticleList
                completion(objArticleList)
            }
            else {
                DispatchQueue.main.async {
                    SharedAlert.alert.displayAlertMessage(viewController: vc, strMessage: MessageConstant.validationMessage.NO_CONTENT, buttonTitle: "OK")
                }
                completion(nil)
            }
        })
    }
    
    
    /*
     * This method will fetch Most Emailed articles from webservice
     */
    
    func fetchMostEmailedArticles(vc:UIViewController?,completion: @escaping (_ articleList:[Article]?) -> Void) {
        
        SharedClass.sharedInstance.showProgressHUD(true)
        
        //Sample URL
        // https://api.nytimes.com/svc/mostpopular/v2/emailed/7.json?api-key=yourkey
        
        
        RequestManager.manager.fetchData(vc,dictparamters:nil, APIName: k_APIHost + k_APIMostEmailedArticleList,HTTPType:"GET",completion: { (responseDictionary:Dictionary<String,Any>?,responseString:String?) -> Void in
            
            SharedClass.sharedInstance.showProgressHUD(false)
            var articleArray:Array<Any>?  = Array()
            articleArray = responseDictionary?["results"] as? Array<Any> ?? nil
            
            var objArticleList:[Article]?
            if articleArray != nil {
                let currentArticleList = try! DictionaryDecoder().decode([Article].self, from: articleArray!)
                objArticleList = currentArticleList
                completion(objArticleList)
            }
            else {
                DispatchQueue.main.async {
                    SharedAlert.alert.displayAlertMessage(viewController: vc, strMessage: MessageConstant.validationMessage.NO_CONTENT, buttonTitle: "OK")
                }
                completion(nil)
            }
        })
    }
    
    
    /*
     * This method will search articles from webservice
     */
    
    func searchFetchArticles(vc:UIViewController?,paramDict:Dictionary<String,Any>,completion: @escaping (_ articleList:[SearchArticle]?) -> Void) {
        
        //Sample URL
    //https://api.nytimes.com/svc/search/v2/articlesearch.json?q=election&page=2&api-key=yourkey

        let urlString:String = k_APIHost + k_APISearchArticleList + "?" + RequestConstant.searchquery + "=" + String(paramDict[RequestConstant.searchquery] as! String) + "&" + RequestConstant.pageNo + "=" + String(paramDict[RequestConstant.pageNo] as! Int)
        
        RequestManager.manager.fetchData(vc,dictparamters:paramDict, APIName: urlString,HTTPType:"GET",completion: { (responseDictionary:Dictionary<String,Any>?,responseString:String?) -> Void in
            var articleArray:Array<Any>?  = Array()
            var currentDict:Dictionary<String,Any> = Dictionary()
            currentDict = responseDictionary?["response"] as! Dictionary<String,Any>
            articleArray = currentDict["docs"] as? Array<Any> ?? nil
            
            var objArticleList:[SearchArticle]?
            if articleArray != nil {
                let currentArticleList = try! DictionaryDecoder().decode([SearchArticle].self, from: articleArray!)
                objArticleList = currentArticleList
                completion(objArticleList)
            }
            else {
                DispatchQueue.main.async {
                    SharedAlert.alert.displayAlertMessage(viewController: vc, strMessage: MessageConstant.validationMessage.NO_CONTENT, buttonTitle: "OK")
                }
                completion(nil)
            }
        })
    }
}
