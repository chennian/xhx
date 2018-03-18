//
//  ZJHomePageViewController.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/3/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJHomePageViewController: SNBaseViewController {

    var pageNum = 1
    var pages = 1
    
    var shoppingModel:LBShoppingModel?
    lazy var cellItem:[shoppingCellTye] = [shoppingCellTye]()
    
    fileprivate var  city = LBKeychain.get(LOCATION_CITY_KEY)
    fileprivate var  lng = LBKeychain.get(longiduteKey)
    fileprivate var  lat = LBKeychain.get(latitudeKey)
    fileprivate var shopName = ""
    
    // CADisplayLink
    fileprivate var disPlayLink:CADisplayLink?
    fileprivate lazy var searchBar = LBShoppingSearchBar()
    
    let tableview = SNBaseTableView(frame: CGRect.zero, style: UITableViewStyle.grouped).then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(ZJHomeBannerCell.self)
        $0.register(ZJHomeClassCell.self)
        $0.register(ZJHomeTitleCell.self)
        $0.register(ZJSpaceCell.self)
        $0.register(ZJHomeSeckillCell.self)
        $0.register(ZJHomeGroupCell.self)
        $0.register(ZJHomeMerchantCell.self)
    }
    override func viewAppear(_ animated: Bool) {
        super.viewAppear(animated)
        navigationController?.navigationBar.addSubview(searchBar)
    }
    
    override func setupView() {
        
    }
    
    override func bindEvent() {
//        tableView.addPullRefresh {[unowned self ] in
//            SZLocationManager.shareUserInfonManager.startUpLocation()
//            guard self.pageNum < self.pages else{
//                self.tableView.stopPullRefreshEver()
//                return
//            }
//            self.cellItem.removeAll()
//            self.loadData()
//        }
    }
    
}
