//
//  LBShopSearchResultViewController.swift
//  LittleBlackBear
//
//  Created by 蘇崢 on 2018/2/4.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class LBShopSearchResultViewController: UIViewController {
	
	
	public var originData: [shoppingCellTye] = []
	fileprivate let tableView = UITableView()
	fileprivate var searchResults: [shoppingCellTye] = [] {
		didSet {
			tableView.reloadData()
		}
	}
    
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
    
	private func configTableView() {
		
		automaticallyAdjustsScrollViewInsets = false
		tableView.estimatedRowHeight = 0
		tableView.estimatedSectionFooterHeight = 0
		tableView.estimatedSectionHeaderHeight = 0
		tableView.delegate = self
		tableView.dataSource = self
		tableView.keyboardDismissMode = .onDrag

		view.addSubview(tableView)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|",
														   options: NSLayoutFormatOptions.alignAllCenterY,
														   metrics: nil,
														   views: ["tableView": tableView]))
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-\(NAV_BAR_HEIGHT)-[tableView]-0-|",
														   options: NSLayoutFormatOptions.alignAllCenterX,
														   metrics: nil,
														   views: ["tableView": tableView]))
		LBShoppingTableViewCellFactory.registerApplyTableViewCell(tableView)
	}

	
}
// MARK: UITableViewDelegate  UITableViewDataSource
extension LBShopSearchResultViewController:UITableViewDelegate,UITableViewDataSource{
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	
		return searchResults.count

	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	
		
		let cell  = LBShoppingTableViewCellFactory.dequeueReusableCell(withTableView: tableView, indexPath: indexPath, cellItems: searchResults)
		cell.selectionStyle = .none
		cell.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
		cell.currentIndexPath = indexPath
		return cell
	}
	
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		switch searchResults[indexPath.row] {
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
		
		switch searchResults[indexPath.row] {
		case let .mixCell(model):
			
			let viewController = LBShoppingMallDetailViewController()
			viewController.orgCode = model.orgcode
			viewController.mercId = model.mercId
			presentingViewController?.navigationController?.pushViewController(viewController, animated: true)

		default:
			break
		}
	}
}
// MARK:UISearchResultsUpdating
extension LBShopSearchResultViewController:UISearchResultsUpdating{
	
	func updateSearchResults(for searchController: UISearchController) {
 		guard let query = searchController.searchBar.text?.trimmed,query.count > 0 else {return}
		
		searchResults = originData.filter{
			switch $0{
			case .mixCell(let model):
			return	model.merShortName.lowercased().contains(query.lowercased())
			default:return false
			}
		}
	}
	


	
}

