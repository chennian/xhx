//
//  LBCityListViewController.swift
//  LittleBlackBear
//
//  Created by Apple on 2017/12/1.
//  Copyright © 2017年 蘇崢. All rights reserved.
//

import UIKit

class LBCityListViewController: UITableViewController {
    
    var selectCity:((String)->())?

    fileprivate let reuseIdentifier0 = "location_now"
	fileprivate let reuseIdentifier1 = "hotCity"
	fileprivate let reuseIdentifier2 = "historyCity"
	fileprivate let reuseIdentifier3 = "default"
    
    fileprivate var defaultCityList:[String] = [String]()
	fileprivate var cityValueList:[String] = [String]()
    fileprivate var citykeyList:[String] = [String]()
	fileprivate var cityJson:[String:Any] = [String:String]()
    
    fileprivate lazy var searchResultVC:LBCitySearchResultTableViewController={
        let viewController = LBCitySearchResultTableViewController()
        return viewController
    }()
    
    fileprivate lazy var searchController:UISearchController={
        let searchController = UISearchController(searchResultsController:self.searchResultVC)
        searchController.searchBar.placeholder = "搜索城市名称"
        searchController.searchResultsUpdater = self.searchResultVC
        
        searchController.searchBar.tintColor = COLOR_ffffff
        searchController.searchBar.barTintColor = UIColor.groupTableViewBackground
        // SearchBar 边框颜色
        searchController.searchBar.layer.borderWidth = 0.5
        searchController.searchBar.layer.borderColor = UIColor.groupTableViewBackground.cgColor
        searchController.searchBar.subviews.forEach{
            if let button:UIButton = $0 as?UIButton{
                button.setTitleColor(UIColor.black, for: .normal)
            }
        }
        
        
        return searchController
    }()
    
    fileprivate let hotCitys = ["上海","北京","杭州","长沙",
                                "广州","深圳","成都","苏州",
                                "南京","天津","重庆","厦门",
                                "武汉","西安"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
		loadCityData ()
        configTableView()
        navigationItem.title = "选择城市"

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
      

    }
   private func configTableView()  {
    
        automaticallyAdjustsScrollViewInsets = false
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.sectionIndexColor = COLOR_e60013
        tableView.sectionIndexMinimumDisplayRowCount = 30
        tableView.sectionIndexBackgroundColor = UIColor.white
		
        tableView.register(LBCityListTableViewCell.self, forCellReuseIdentifier: reuseIdentifier0)
        tableView.register(LBCityListTableViewCell.self, forCellReuseIdentifier: reuseIdentifier1)
        tableView.register(LBCityListTableViewCell.self, forCellReuseIdentifier: reuseIdentifier2)
        tableView.register(LBCityListTableViewCell.self, forCellReuseIdentifier: reuseIdentifier3)
    
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true

        searchResultVC.searchResultAction = {[weak self](city)in
            guard let strongSelf = self else { return  }
            guard let action = strongSelf.selectCity else { return  }
            action(city)
            strongSelf.navigationController?.popViewController(animated: true)

    }
    
    }
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if #available(iOS 11.0, *){
            if scrollView.contentOffset.y == 0{
                navigationItem.hidesSearchBarWhenScrolling = false
            }else{
                navigationItem.hidesSearchBarWhenScrolling = true
            }
        }
    }
	
	
}
// MARK: - Table view data source
extension LBCityListViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return citykeyList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection(section: section)
    }
    private func numberOfRowsInSection(section: Int) -> Int {
        switch section {
        case 0,1:
            return 1
        default:
            return (cityJson[citykeyList[section-2]] as! [String]).count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier0, for: indexPath) as! LBCityListTableViewCell
            cell.cellType = .location_now
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier1, for: indexPath) as! LBCityListTableViewCell
            cell.cellType = .hotCity
            cell.delegate = self
            return cell
            //        case 1:
            //            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier2, for: indexPath) as! LBCityListTableViewCell
            //            cell.cellType = .historyCity
            //            cell.delegate = self
        //            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier3, for: indexPath) as! LBCityListTableViewCell
            
            let vlueList = cityJson[citykeyList[indexPath.section-2]] as! [String]
            cell.cellType = .default
            cell.titleLabel.text =  vlueList[indexPath.row]
            return cell
        }
        
    }


	override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
    	Print(tableView.visibleCells)
        return ["热门"]+citykeyList
	}
	
	override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let view  = UIView()
        view.backgroundColor = COLOR_e6e6e6
        let label = UILabel()
        label.textColor = COLOR_222222
        label.backgroundColor = COLOR_e6e6e6
        label.text = (["","热门城市"]+citykeyList)[section]
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        view.addConstraint(BXLayoutConstraintMake(label, .left, .equal,view,.left,20))
        view.addConstraint(BXLayoutConstraintMake(label, .centerY, .equal,view,.centerY))
        return view
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let action = selectCity else {return}
      if indexPath.section != 1 {

            indexPath.section == 0 ? action(LBKeychain.get(LOCATION_CITY_KEY)): action((cityJson[citykeyList[indexPath.section-2]] as! [String])[indexPath.row])
         
        }
        navigationController?.popViewController(animated: true)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 1:
            return  180
        default:
            return 45
            
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section != 0 else {
            return 0.001
        }
        return 30
    }
}
// MARK: LBCityListTableViewCellDegate
extension LBCityListViewController:LBCityListTableViewCellDegate{
	
	func numberOfSections(in collectionView: UICollectionView) -> Int{
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 12
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
		let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LBCityCollectionViewCell", for: indexPath) as! LBCityCollectionViewCell
		cell.titleLabel_text = hotCitys[indexPath.row]
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        guard let action = selectCity else {return}
        action(hotCitys[indexPath.row])
        navigationController?.popViewController(animated: true)
	}
}

// MARK: loadCityData
extension LBCityListViewController{
    
	fileprivate func loadCityData ()  {
		guard let jsonPath = Bundle.main.path(forResource: "citydict", ofType: "plist") else {
			Print("路径有毛病")
			return
		}
		let jsonResult = NSDictionary(contentsOfFile: jsonPath)
		cityJson = jsonResult as! [String:Any]
		let json = LBJSON(jsonResult!)
        searchResultVC.originData.removeAll()
		json.forEach({ (key,value) in
			citykeyList.append(key)
            value.arrayValue.forEach{
                cityValueList.append($0.stringValue)
                searchResultVC.originData.append($0.stringValue)
            }
            
		})
		json.forEach({ (key,value) in
				defaultCityList.append(value.stringValue)

		})
		citykeyList = citykeyList.sorted(by: {$0<$1})
	}
}






