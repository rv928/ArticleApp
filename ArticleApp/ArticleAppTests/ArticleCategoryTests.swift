//
//  ArticleCategoryTests.swift
//  ArticleAppTests
//
//  Created by Admin on 09/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import XCTest
@testable import ArticleApp

class ArticleCategoryTests: XCTestCase {

    var controller: ArticleCategoryViewController!
    var tableView: UITableView!
    var delegate: UITableViewDelegate!
    var groupListArray:Array<Group> = Array()
    
    override func setUp() {
        guard let nav = UIStoryboard(name: "Article", bundle: Bundle(for: ArticleCategoryViewController.self)).instantiateInitialViewController() as? UINavigationController
            else {
                return XCTFail("Could not instantiate ViewController from Article storyboard")
        }
        controller = nav.topViewController as? ArticleCategoryViewController
        controller.loadViewIfNeeded()
        tableView = controller.groupTableView
        delegate = tableView.delegate
    }

    func testTableViewHasCategoryCells() {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell")
        
        XCTAssertNotNil(cell,
                        "TableView should be able to dequeue cell with identifier: 'CategoryListCell'")
    }
    
    func testTableViewDelegateIsViewController() {
        XCTAssertTrue(tableView.delegate === controller,
                      "Controller should be delegate for the table view")
    }
    
    func testTableViewIsCellIsSearch() {
        var categoryDict:Dictionary<String,Any>  = Dictionary()
        categoryDict[ResponseConstant.groupType] = GroupType.search.rawValue
        categoryDict[ResponseConstant.groupObject] = nil
        let categoryGroup:Group = Group(dictionary: categoryDict)
        self.groupListArray.append(categoryGroup)
        
        let currentGroup:Group = self.groupListArray[0]
        XCTAssertTrue(currentGroup.groupType == GroupType.search.rawValue,
                      "cell is search")
    }
    
    func testTableViewIsCellIsPopular() {
        var categoryDict:Dictionary<String,Any>  = Dictionary()
        categoryDict[ResponseConstant.groupType] = GroupType.popular.rawValue
        categoryDict[ResponseConstant.groupObject] = nil
        let categoryGroup:Group = Group(dictionary: categoryDict)
        self.groupListArray.append(categoryGroup)
        
        let currentGroup:Group = self.groupListArray[0]
        XCTAssertTrue(currentGroup.groupType == GroupType.popular.rawValue,
                      "cell is popular")
    }
    
    func testForCategoryDetails() {
        let cell:CategoryListCell = tableView.dequeueReusableCell(withIdentifier: "CategoryListCell") as! CategoryListCell
        var checkArray:Array<String> = Array()
        checkArray.append("abc")
        checkArray.append("def")

        var categoryDict:Dictionary<String,Any>  = Dictionary()
        categoryDict[ResponseConstant.groupType] = GroupType.popular.rawValue
        categoryDict[ResponseConstant.groupObject] = checkArray
        
        let categoryGroup:Group = Group(dictionary: categoryDict)
        self.groupListArray.append(categoryGroup)
        
        let categoryArray:Array<String> = categoryGroup.groupObject!
        XCTAssertNoThrow(cell.setCategoryDetails(currentCategory:categoryArray[0]))
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
