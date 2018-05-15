//
//  ZJGoodListViewController.swift
//  LittleBlackBear
//
//  Created by MichaelChan on 10/5/18.
//  Copyright © 2018年 蘇崢. All rights reserved.
//

import UIKit

class ZJGoodListViewController: SNBaseViewController {

    let tableview = SNBaseTableView().then({
        $0.register(ZJShopDetailGoodsCell.self)
        $0.backgroundColor = Color(0xf5f5f5)
    })
    var shopId : String = ""{
        didSet{
            viewmodel.requestData(shopId: shopId)
        }
    }

    let header = ZJGoodListHeaderView()
    
    let viewmodel = ZJGoodListViewModel()
    override func setupView() {
        title = "全部商品"
        view.addSubview(header)
//        automaticallyAdjustsScrollViewInsets = false
        view.addSubview(tableview)
        header.snp.makeConstraints { (make) in
            make.height.snEqualTo(90)
            make.top.equalToSuperview().snOffset(2)
            make.width.equalToSuperview()
            make.left.equalToSuperview()
        }
        tableview.snp.makeConstraints { (make) in
            make.top.equalTo(header.snp.bottom)
            make.width.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableview.delegate = viewmodel
        tableview.dataSource = viewmodel
//        header.requestViewData()
        
        
    }
    
    override func bindEvent() {
        viewmodel.reloadPub.subscribe(onNext: { (cates) in
            self.header.setCates(cates: cates)
            self.tableview.reloadData()
        }).disposed(by: disposeBag)
    }
    
}
