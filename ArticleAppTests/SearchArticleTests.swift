//
//  SearchArticleTests.swift
//  ArticleAppTests
//
//  Created by Admin on 09/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import XCTest
@testable import ArticleApp

class SearchArticleTests: XCTestCase {

    var controller: SearchArticleViewController!
    var tableView: UITableView!
    var delegate: UITableViewDelegate!
    var articleArray:Array<SearchArticle> = Array()
    var artcileViewModels = [SearchArticleViewModel]()
    
    override func setUp() {
        guard let vc = UIStoryboard(name: "Article", bundle: Bundle(for: SearchArticleViewController.self)).instantiateViewController(withIdentifier: "SearchArticleViewController") as? SearchArticleViewController
            else {
                return XCTFail("Could not instantiate ViewController from Album storyboard")
        }
        controller = vc
        controller.loadViewIfNeeded()
        tableView = controller.articleListTableView
        delegate = tableView.delegate
    }
    
    func testTableViewHasArticleCells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell")
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'ArticleCell'")
    }
    
    func testTableViewDelegateIsViewController() {
        XCTAssertTrue(tableView.delegate === controller,
                      "Controller should be delegate for the table view")
    }

    func testForWSToSearchedArticleList() {
        
        var inputDict:Dictionary<String,Any> = Dictionary()
        inputDict["q"] = "abc"
        inputDict["page"] = 1
        
        XCTAssertNoThrow(ArticleManager.manage.searchFetchArticles(vc: controller, paramDict: inputDict, completion: { (articleList) in
            XCTAssertEqual(articleList?.count, self.articleArray.count)
        }))
    }

    
    func testForArticleCellDetails() {
        let cell:ArticleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as! ArticleCell
        
        var inputDict:Dictionary<String,Any> = Dictionary()
        inputDict["q"] = "abc"
        inputDict["page"] = 1
        
        ArticleManager.manage.searchFetchArticles(vc: controller,paramDict: inputDict,completion: { (articleList) in
            
            self.articleArray = articleList!
            
            for(index,_) in self.articleArray.enumerated() {
                let currentArticle:SearchArticle = self.articleArray[index]
                let currentVModel:SearchArticleViewModel = SearchArticleViewModel(article: currentArticle)
                self.artcileViewModels.append(currentVModel)
                let currentViewModel = self.artcileViewModels[index]
                XCTAssertNoThrow(cell.searcharticleViewModel = currentViewModel)
            }
        })
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
