//
//  SearchArticleViewController.swift
//  ArticleApp
//
//  Created by Admin on 07/05/19.
//  Copyright © 2019 Admin. All rights reserved.
//
//
import UIKit

//Constant for Search TEXT limit

let SEARCH_ARTICLE_TEXT_COUNT = 3

//Constant for total records (in API this parameter is not provided so i put it to test)

let TOTAL_COUNT = 100

class SearchArticleViewController: UIViewController {

    //IBOutlet Properties : -
    @IBOutlet weak var articleListTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!

    ///Properties : -
    var currentSubType:Int = GroupSubType.Viewed.rawValue
    var articleArray:Array<SearchArticle> = Array()
    var pageIndex:Int = 1
    var isPaging : Bool? = false
    var articleCount:Int =  0

    // ViewModel Observer for Searched ArticleList data
    var artcileViewModels = [SearchArticleViewModel]() {
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
        self.title = "Search Articles"
    }
    
    /*
     * This method called on back button clicked
     */
    @objc func backClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    

    // MARK:- WebService Methods
    /*
     * This method will use to Search articles from API
     */
    func callWSToFetcSearchArticles(searchString:String?) {
        
        //Cancellling previous requests for search
        
        CoreWebserviceManager.manager.cancelAllRequests()
        
        //Starting Activity Indicator

        SharedClass.sharedInstance.setActivityIndicatorToTableFooter(table: self.articleListTableView)
        
        
        //Preaparing search request dictionary

        var inputDict:Dictionary<String,Any> = Dictionary()
        
        if(searchString?.isBlank == false){
            inputDict[RequestConstant.searchquery] = searchString
        }
        inputDict[RequestConstant.pageNo] = pageIndex
        
        ArticleManager.manage.searchFetchArticles(vc: self,paramDict:inputDict,completion:{(articleList) -> Void in
            if articleList != nil  {
                
                if articleList == nil {
                    return
                }
                self.articleCount = TOTAL_COUNT
                
                //Hiding Activity Indicator

                SharedClass.sharedInstance.hideActivityIndicatorFromTableFooter(table: self.articleListTableView)
                
                if self.isPaging == true {
                    self.articleArray = self.articleArray + articleList!
                }
                else {
                    self.articleArray = articleList!
                }
                
                //Creating ViewModel for search data

                for(index,_) in self.articleArray.enumerated() {
                    let currentArticle:SearchArticle = self.articleArray[index]
                    let currentVModel:SearchArticleViewModel = SearchArticleViewModel(article: currentArticle)
                    self.artcileViewModels.append(currentVModel)
                }
            }
        })
    }
   
}


// MARK:- UITextfield Delegate Methods

extension SearchArticleViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if( textField == searchTextField) {
            
            if let text = textField.text {
                
                let updatedTextString:String = text.replacingCharacters(in: Range(range, in: text)!,with: string)
                
                if updatedTextString.count >= SEARCH_ARTICLE_TEXT_COUNT {
                    self.isPaging = false
                    pageIndex = 1
                    self.articleArray.removeAll()
                    self.artcileViewModels.removeAll()
                    let newString = updatedTextString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
                    self.callWSToFetcSearchArticles(searchString: newString)
                }
            }
        }
        return true
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.articleArray.removeAll()
        self.artcileViewModels.removeAll()
        self.articleCount = 0
        self.articleListTableView.reloadData()
        return true
    }
}

extension SearchArticleViewController:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.articleArray.count == 0 {
            return
        }
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight = Double(abs(diffHeight - frameHeight));
        var offset:Int = 0
        offset = Int(ceil(Double(articleCount/RequestConstant.kPageSize)))
        if pullHeight <= 1.0 && pageIndex <= offset {
            print("load more trigger")
            pageIndex = pageIndex + 1
            isPaging = true
            self.callWSToFetcSearchArticles(searchString: searchTextField.text)
        }
    }
}

// MARK:- UITableView Delegate Methods

extension SearchArticleViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TagIDConstant.cellIDs.kArticleCell, for: indexPath) as! ArticleCell
        let currentViewModel = artcileViewModels[indexPath.row]
        cell.searcharticleViewModel = currentViewModel
        cell.selectionStyle = .none
        return cell
    }
}
