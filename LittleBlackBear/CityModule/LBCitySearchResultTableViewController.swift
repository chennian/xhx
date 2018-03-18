//
//  LBCitySearchResultTableViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2018/2/5.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit
class LBCitySearchResultTableViewController: UITableViewController {
    fileprivate let reuseIdentifier = "LBCitySearchResultTableViewController"
    
    var originData:[String] = []
    var searchResultAction:((String)->())?
    
   fileprivate var searchResults:[String] = []{
        didSet{
            guard searchResults.count > 0 else{return}
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.rowHeight = 45
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.contentInset = UIEdgeInsetsMake(NAV_BAR_HEIGHT, 0, 0, 0 )
        definesPresentationContext = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.font = FONT_28PX
        cell.textLabel?.text = searchResults[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let action = searchResultAction else {return}
        action(searchResults[indexPath.row])
    }
    
}
// MARK: UISearchResultsUpdating
extension LBCitySearchResultTableViewController:UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text?.trimmed,query.count > 0 else {return}
        
        searchResults = originData.filter{$0.lowercased().contains(query.lowercased())}
     
    }
    
    
    
    
}
