//
//  LBShoppingNextViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/13.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBShoppingNextViewController: UIViewController {
    
    var mercId:String  = ""
    var subCataId:String = ""
    var  city = ""
    var  lng = ""
    var  lat = ""
    fileprivate var shopName = ""
    var paramert:[String:Any]?{
        didSet{
            guard paramert != nil,paramert!.count != 0 else{return}
            loadData(paramert: paramert!)
        }
    }
    
	fileprivate lazy var searchResultVC: LBShopSearchResultViewController = {
		return LBShopSearchResultViewController()
	}()

	fileprivate lazy var searchController:UISearchController={
		let searchController = UISearchController(searchResultsController:self.searchResultVC)
		searchController.searchBar.placeholder = "搜索店铺名称"
		searchController.searchResultsUpdater = self.searchResultVC
		
		searchController.searchBar.tintColor = COLOR_ffffff
		searchController.searchBar.barTintColor = UIColor.groupTableViewBackground
		// SearchBar 边框颜色
		searchController.searchBar.layer.borderWidth = 0.5
		searchController.searchBar.layer.borderColor = UIColor.groupTableViewBackground.cgColor
		Print(searchController.searchBar.subviews)
		searchController.searchBar.subviews.forEach{
			if let button:UIButton = $0 as?UIButton{
				button.setTitleColor(UIColor.black, for: .normal)
			}
		}


		return searchController
	}()
    
    fileprivate let headerView = LBShoppingHeaderView()
    fileprivate let searchBar = LBShoppingSearchBar()
    fileprivate var shoppingModel:LBShoppingModel?
    fileprivate var cellItem:[shoppingCellTye] = []
    fileprivate var searchCellItem:[shoppingCellTye] = [shoppingCellTye]()
    fileprivate let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        self.automaticallyAdjustsScrollViewInsets=false
        configTableView()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func configTableView() {
        
        automaticallyAdjustsScrollViewInsets = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.delegate = self
        tableView.dataSource = self
		tableView.tableHeaderView = searchController.searchBar
		definesPresentationContext = true

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|",
                                                           options: NSLayoutFormatOptions.alignAllCenterY,
                                                           metrics: nil,
                                                           views: ["tableView": tableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|",
                                                           options: NSLayoutFormatOptions.alignAllCenterX,
                                                           metrics: nil,
                                                           views: ["tableView": tableView]))
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        LBShoppingTableViewCellFactory.registerApplyTableViewCell(tableView)
    }
    

    
    
}
// MARK: UITableViewDelegate  UITableViewDataSource
extension LBShoppingNextViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
		
        return shoppingModel?.detail.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  shoppingModel != nil ?cellItem.count:0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
        let cell  = LBShoppingTableViewCellFactory.dequeueReusableCell(withTableView: tableView, indexPath: indexPath, cellItems: cellItem)
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
        cell.currentIndexPath = indexPath
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
        switch cellItem[indexPath.row] {
        case .title(_):
            return 44.0
        case .mixCell(_):
            return 140*AUTOSIZE_Y
        case .button(_):
            return 55
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
        switch cellItem[indexPath.row] {
        case .button(_):
            loadData(paramert:paramert!)
        case let .mixCell(model):
            let viewController = LBShoppingMallDetailViewController()
            viewController.orgCode = model.orgcode
            viewController.mercId = model.mercId
            navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
// MARK: UISearchControllerDelegate,UISearchResultsUpdating
extension LBShoppingNextViewController:UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let shopName = searchController.searchBar.text,shopName.count > 0 else {return}
        searchAction(shopName)
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        Print(searchController.isActive)
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let shopName = searchBar.text,shopName.count > 0 else {return}
        searchAction(shopName)
        
        
    }
    
    func searchAction(_ text:String){
        let mercId = LBKeychain.get(CURRENT_MERC_ID)
        let pageSize = 10
        let lng = LBKeychain.get(longiduteKey)
        let lat = LBKeychain.get(latitudeKey)
        let city = LBKeychain.get(LOCATION_CITY_KEY)
        let paramert:[String:Any] = ["mercIcid":mercId,"city":city,"pageSize":pageSize,"lng":lng,"lat":lat,"merShortName":shopName]
        requiredMainIndexData(paramert: lb_md5Parameter(parameter: paramert), compeletionHandler: {[weak self]  (model) in
            guard let strongSelf = self else {return}
            strongSelf.shoppingModel = model
            if strongSelf.searchCellItem.count > 0 {
                strongSelf.searchCellItem.removeAll()
            }
            model.merInfos.forEach{
                strongSelf.searchCellItem.append(.mixCell($0))
            }
            strongSelf.tableView.reloadData()
        }) {
            
        }
    }
    
}
extension LBShoppingNextViewController:LBShoppingHttpServer{
    
    func loadData(paramert:[String:Any])  {
        
        requiredMainIndexData(paramert: lb_md5Parameter(parameter: paramert), compeletionHandler: {[weak self] (model) in
            guard let strongSelf = self else {return}
            strongSelf.shoppingModel = model
            if strongSelf.cellItem.count > 0 {
                strongSelf.cellItem.removeAll()
            }
            model.merInfos.forEach{
                strongSelf.cellItem.append(.mixCell($0))
				strongSelf.searchResultVC.originData.append(.mixCell($0))
            }
            strongSelf.tableView.reloadData()
            
        }) {
            
        }
        
    }
}
