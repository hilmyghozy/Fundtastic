//
//  NewsViewController.swift
//  Fundtastic
//
//  Created by hilmy ghozy on 06/12/21.
//

import UIKit
import SDWebImage

class NewsViewController: UIViewController{

    @IBOutlet var tableView: UITableView!
    var category = String()
    
    var searchBar = UISearchBar()
    var isSearching = false
    var presenter : CategoryPresenter = CategoryPresenter()
    var categoryArr : [CategoryModel] = []
    var searchingArr : [CategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.delegate = self
        self.presenter.doGetAllItem(category: category)
        
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "NewsTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        searchBar.delegate = self
        searchingArr = categoryArr
        searchBar.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 40)
        searchBar.placeholder = "Search in \(category.capitalized)..."
        let navSearchBar = UIBarButtonItem(customView:searchBar)
        self.navigationItem.rightBarButtonItem = navSearchBar
        
        self.navigationController?.navigationBar.tintColor = .black
        
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching{
            return self.searchingArr.count
        }else {
            return self.categoryArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        
        let category = isSearching == true ? self.searchingArr[indexPath.row] : self.categoryArr[indexPath.row]
        
        if category.urlToImage != nil {
            cell.contentImageView.sd_setImage(with: URL.init(string: category.urlToImage!), completed: nil)
        }else{
            cell.contentImageView.image = UIImage(named: "logo")
        }
        
        cell.titleLabel.text = category.title
        cell.contentLabel.text = category.description
        cell.authorLabel.text = category.author ?? "Anonimous"
        cell.dateLabel.text = category.publishedAt
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let items = self.categoryArr[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle:nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "WebViewController") as? WebViewController{
            vc.web = items.url ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        
        searchingArr = []
        
        if searchText == "" {
            searchingArr = categoryArr
        }
        
        for search in categoryArr {
            if search.title!.contains(searchText) {
                searchingArr.append(search)
                print(search)
            }
        }
        self.tableView.reloadData()
    }
}

extension NewsViewController: CategoryDelegate {
    func didSuccessGetItems() {
        if let response = self.presenter.responseItems?.articles {
            self.categoryArr = response
        }
        self.tableView.reloadData()
    }
    
    func didFailedGetItems(errorMessage: String) {}
}
