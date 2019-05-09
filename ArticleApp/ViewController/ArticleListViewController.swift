//
//  ArticleListViewController.swift
//  ArticleApp
//
//  Created by Admin on 07/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import UIKit

//Height Constant for ArticleCell Height

struct ArticleCellHeight {
    static let cellHeight = 55
}

class ArticleListViewController: UIViewController {

    //IBOutlet Properties : -
    @IBOutlet weak var articleListTableView: UITableView!
    
    //Properties : -
    var currentSubType:Int = GroupSubType.Viewed.rawValue
    var articleArray:Array<Article> = Array()
    
    // ViewModel Observer for ArticleList data
     var artcileViewModels = [ArticleViewModel]() {
        didSet {
            DispatchQueue.main.async {
                self.articleListTableView.reloadData()
            }
        }
    }
    
    // MARK:- View Life cycle methods

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    

    // MARK:- UI Methods
    
    func setupUI() {
        self.registerNibs()
        self.setupNavigationBar()
        
        if currentSubType == GroupSubType.Viewed.rawValue {
            self.callWSToFetchMostViewArticles()
            self.title = "Most Viewed Articles"
        }
        else if currentSubType == GroupSubType.Shared.rawValue {
            self.callWSToFetchMostSharedArticles()
            self.title = "Most Shared Articles"
        }
        else {
            self.callWSToFetchMostEmailedArticles()
            self.title = "Most Emailed Articles"
        }
    }

    
    /*
     * This method will setup nib for ArticleCell
     */
    func registerNibs() {
        
        let nib1 = UINib(nibName: TagIDConstant.cellIDs.kArticleCell, bundle: nil)
        articleListTableView.register(nib1, forCellReuseIdentifier: TagIDConstant.cellIDs.kArticleCell)
        articleListTableView.tableFooterView = UIView()
        
        self.articleListTableView.tableFooterView = UIView(frame: CGRect.zero)
        self.articleListTableView.accessibilityIdentifier = "table--articleListTableView"
        articleListTableView.rowHeight = UITableView.automaticDimension
        articleListTableView.estimatedRowHeight = CGFloat(ArticleCellHeight.cellHeight)
    }
    
    
    /*
     * This method will setup NavigationBar
     */
    func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.appColor, alpha: 1.0)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: SharedClass.sharedInstance.colorWithHexStringAndAlpha(UIConstant.navTextColor, alpha: 1.0)]
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named:UIConstant.Images.backIcon), for: .normal)
        button.addTarget(self, action: #selector(self.backClicked), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    
    /*
     * This method called on back button clicked
     */
    @objc func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK:- WebService Methods
    /*
     * This method will use to fetch Most Viewed articles from API
     */
    func callWSToFetchMostViewArticles() {
        
        ArticleManager.manage.fetchMostViewedArticles(vc: self,completion:{(articleList) -> Void in
            if articleList != nil  {
                //print(articleList)
                self.articleArray.removeAll()
                self.articleArray = articleList!
                
                for(index,_) in self.articleArray.enumerated() {
                    let currentArticle:Article = self.articleArray[index]
                    let currentVModel:ArticleViewModel = ArticleViewModel(article: currentArticle)
                    self.artcileViewModels.append(currentVModel)
                }
            }
        })
    }
    
    
    /*
     * This method will use to fetch Most Shared articles from API
     */
    func callWSToFetchMostSharedArticles() {
        
        ArticleManager.manage.fetchMostSharedArticles(vc: self,completion:{(articleList) -> Void in
            if articleList != nil  {
                //print(articleList)
                self.articleArray.removeAll()
                self.articleArray = articleList!
                
                for(index,_) in self.articleArray.enumerated() {
                    let currentArticle:Article = self.articleArray[index]
                    let currentVModel:ArticleViewModel = ArticleViewModel(article: currentArticle)
                    self.artcileViewModels.append(currentVModel)
                }
            }
        })
    }
    
    /*
     * This method will use to fetch Most Emailed articles from API
     */
    func callWSToFetchMostEmailedArticles() {
        
        ArticleManager.manage.fetchMostEmailedArticles(vc: self,completion:{(articleList) -> Void in
            if articleList != nil  {
                //print(articleList)
                self.articleArray.removeAll()
                self.articleArray = articleList!
                
                for(index,_) in self.articleArray.enumerated() {
                    let currentArticle:Article = self.articleArray[index]
                    let currentVModel:ArticleViewModel = ArticleViewModel(article: currentArticle)
                    self.artcileViewModels.append(currentVModel)
                }
            }
        })
    }
}

// MARK:- UITableView Delegate Methods

extension ArticleListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.artcileViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TagIDConstant.cellIDs.kArticleCell, for: indexPath) as! ArticleCell
        let currentViewModel = artcileViewModels[indexPath.row]
        cell.articleViewModel = currentViewModel
        cell.selectionStyle = .none
        return cell
    }
}
