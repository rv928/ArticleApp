//
//  ArticleCategoryViewController.swift
//  ArticleApp
//
//  Created by Admin on 07/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

//Enum for GroupType

enum GroupType:Int {
    case search = 1
    case popular = 2
}

//Enum for GroupSubType

enum GroupSubType:Int {
    case Viewed = 1
    case Shared = 2
    case Emailed = 3
}

//Height Constant for CategoryListCell Height

struct CategoryListCellHeight {
    static let cellHeight = 44
    static let sectionHeight = 44
}
class ArticleCategoryViewController: UIViewController {

    //IBOutlet Properties : -
    @IBOutlet weak var groupTableView: UITableView!
    
    ///Properties : -
    var groupListArray:Array<Group> = Array()
    var searchArray:Array<String> = Array()
    var popularArray:Array<String> = Array()
    
    
    
    // MARK:- View Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    
    // MARK:- UI Methods
    
    func setupUI() {
        self.registerNibs()
        self.setupNavigationBar()
        self.prepareTableViewObject()
    }
    
    /*
     * This method will setup nib for CategoryListCell
     */
    func registerNibs() {
        let headerNib = UINib.init(nibName: TagIDConstant.nibs.kGroupHeaderView, bundle: Bundle.main)
        groupTableView.register(headerNib, forHeaderFooterViewReuseIdentifier: TagIDConstant.nibs.kGroupHeaderView)
        
        let nib1 = UINib(nibName: TagIDConstant.cellIDs.kCategoryListCell, bundle: nil)
        groupTableView.register(nib1, forCellReuseIdentifier: TagIDConstant.cellIDs.kCategoryListCell)
        groupTableView.tableFooterView = UIView()
        
        self.groupTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.groupTableView.accessibilityIdentifier = "table--groupTableView"
    }
    
    
    /*
     * This method will setup NavigationBar
     */
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appColor, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.navTextColor, alpha: 1.0)]
        self.title = "Articles"
    }
   
   
    /*
     * This method will prepare UITableViewData
     */
    func prepareTableViewObject() {
        searchArray.append("Search Articles")
        
        popularArray.append("Most Viewed")
        popularArray.append("Most Shared")
        popularArray.append("Most Emailed")
        
        let currentGroupSearch:Group = Group(dictionary: [:])
        currentGroupSearch.groupObject = self.searchArray
        currentGroupSearch.groupType = GroupType.search.rawValue
        
        let currentGroupPopular:Group = Group(dictionary: [:])
        currentGroupPopular.groupObject = self.popularArray
        currentGroupPopular.groupType = GroupType.popular.rawValue
        
        self.groupListArray.append(currentGroupSearch)
        self.groupListArray.append(currentGroupPopular)
    }
}


// MARK:- UITableView Delegate Methods

extension ArticleCategoryViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if self.groupListArray.count > 0 {
            if (self.groupListArray.count) > 0 {
                tableView.backgroundView = nil
                return self.groupListArray.count
            }
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let currentGroup:Group = self.groupListArray[section]
        return currentGroup.groupObject?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TagIDConstant.nibs.kGroupHeaderView) as? GroupHeaderView ?? GroupHeaderView(reuseIdentifier: TagIDConstant.nibs.kGroupHeaderView)
        let currentGroup:Group = self.groupListArray[section]
        
        if currentGroup.groupType == GroupType.search.rawValue {
            headerView.headerLabel.text = "Search"
        }
        else {
            headerView.headerLabel.text = "Popular"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(CategoryListCellHeight.sectionHeight)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(CategoryListCellHeight.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentGroup:Group = self.groupListArray[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TagIDConstant.cellIDs.kCategoryListCell, for: indexPath) as! CategoryListCell
        let categoryArray:Array<String> = currentGroup.groupObject!
        cell.setCategoryDetails(currentCategory: categoryArray[indexPath.row])
        cell.selectionStyle = .none
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentGroup:Group = self.groupListArray[indexPath.section]
        
        if currentGroup.groupType! == GroupType.popular.rawValue {
            
              let objArticleListViewController: ArticleListViewController = self.storyboard?.instantiateViewController(withIdentifier: TagIDConstant.storyBoardIDs.kArticleListViewController) as! ArticleListViewController
            
            if indexPath.row == 0 {
                objArticleListViewController.currentSubType = GroupSubType.Viewed.rawValue
            }
            else if indexPath.row == 1 {
                objArticleListViewController.currentSubType = GroupSubType.Shared.rawValue
            }
            else {
                objArticleListViewController.currentSubType = GroupSubType.Emailed.rawValue
            }
            self.navigationController?.pushViewController(objArticleListViewController, animated: true)

        }
        else {
            let objSearchArticleViewController: SearchArticleViewController = self.storyboard?.instantiateViewController(withIdentifier: TagIDConstant.storyBoardIDs.kSearchArticleViewController) as! SearchArticleViewController
            self.navigationController?.pushViewController(objSearchArticleViewController, animated: true)
        }
    }
}
