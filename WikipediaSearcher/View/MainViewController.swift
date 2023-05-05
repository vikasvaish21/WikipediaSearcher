//
//  ViewController.swift
//  WikipediaSearcher
//
//  Created by Vikas Vaish on 04/05/23.
//

import UIKit

class MainViewController: UIViewController {
    
    private let wikipediaSearchBar = UISearchBar()
    private let WikipediaResultTableView = UITableView()
    var wikiResult = [Page]()
    var searchedText = ""
    var viewModel = WikipediaViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setUpWikipediaSearchBar()
        configureTableView()
        viewModel.delegate = self
  
        // Do any additional setup after loading the view.
    }
    
    
    func setupNavigationBar(){
        navigationItem.title = "Result"
        navigationController?.navigationBar.tintColor = UIColor.white
        //        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "save"), style: .plain, target: self, action: #selector(handleRightButtonAction))
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor.primaryColor
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,.font: UIFont(name: "Avenir", size:20)!]
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
        }
    }
    
    
    func setUpWikipediaSearchBar() {
        view.addSubview(wikipediaSearchBar)
        wikipediaSearchBar.delegate = self
        wikipediaSearchBar.backgroundColor = UIColor.primaryColor
        wikipediaSearchBar.showsCancelButton = false
        wikipediaSearchBar.searchTextField.clearButtonMode = .never
        wikipediaSearchBar.translatesAutoresizingMaskIntoConstraints = false
        wikipediaSearchBar.anchor(top: view.layoutMarginsGuide.topAnchor,left: view.leftAnchor,right: view.rightAnchor)
        wikipediaSearchBar.barTintColor =  .primaryColor
        wikipediaSearchBar.searchTextField.backgroundColor = .white
    }
    
    
    func configureTableView() {
        WikipediaResultTableView.delegate = self
        WikipediaResultTableView.dataSource = self
        WikipediaResultTableView.estimatedRowHeight = 100
        WikipediaResultTableView.rowHeight = UITableView.automaticDimension
        WikipediaResultTableView.register(WikipediaResultTableviewCell.self, forCellReuseIdentifier: WikipediaResultTableviewCell.reuseId)
        view.addSubview(WikipediaResultTableView)
        WikipediaResultTableView.translatesAutoresizingMaskIntoConstraints = false
        WikipediaResultTableView.topAnchor.constraint(equalTo: wikipediaSearchBar.bottomAnchor).isActive = true
        WikipediaResultTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        WikipediaResultTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        WikipediaResultTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
   
    
}


extension MainViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wikiResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WikipediaResultTableviewCell.reuseId, for: indexPath) as! WikipediaResultTableviewCell
        cell.setup(responseData: wikiResult, itemIndex: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
   


}

extension MainViewController: WikipediaDataProtocol{
    func sendResultData(_ data: ResultModel) {
        if let arrayData = data.query?.pages?.values{
            wikiResult += arrayData
        }
        DispatchQueue.main.async {
            self.reloadTableview()
        }
    }
    
    func reloadTableview() {
        self.WikipediaResultTableView.reloadData()
        
    }
}

extension MainViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            wikiResult.removeAll()
            searchedText = searchText
            viewModel.getSearchResult(searchedText)
        } else{
            searchedText = searchText
            WikipediaResultTableView.reloadData()
            searchBar.endEditing(true)
        }
    }
}
